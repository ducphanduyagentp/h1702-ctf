package android.support.v7.widget;

import android.app.SearchManager;
import android.app.SearchableInfo;
import android.content.ComponentName;
import android.content.Context;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.res.ColorStateList;
import android.database.Cursor;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.Drawable.ConstantState;
import android.net.Uri.Builder;
import android.os.Bundle;
import android.support.v4.widget.ResourceCursorAdapter;
import android.support.v7.appcompat.R;
import android.text.SpannableString;
import android.text.TextUtils;
import android.text.style.TextAppearanceSpan;
import android.util.Log;
import android.util.TypedValue;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import java.util.WeakHashMap;

class SuggestionsAdapter extends ResourceCursorAdapter implements OnClickListener {
    private static final boolean DBG = false;
    static final int INVALID_INDEX = -1;
    private static final String LOG_TAG = "SuggestionsAdapter";
    private static final int QUERY_LIMIT = 50;
    static final int REFINE_ALL = 2;
    static final int REFINE_BY_ENTRY = 1;
    static final int REFINE_NONE = 0;
    private boolean mClosed = false;
    private final int mCommitIconResId;
    private int mFlagsCol = -1;
    private int mIconName1Col = -1;
    private int mIconName2Col = -1;
    private final WeakHashMap<String, ConstantState> mOutsideDrawablesCache;
    private final Context mProviderContext;
    private int mQueryRefinement = 1;
    private final SearchManager mSearchManager = ((SearchManager) this.mContext.getSystemService("search"));
    private final SearchView mSearchView;
    private final SearchableInfo mSearchable;
    private int mText1Col = -1;
    private int mText2Col = -1;
    private int mText2UrlCol = -1;
    private ColorStateList mUrlColor;

    private static final class ChildViewCache {
        public final ImageView mIcon1;
        public final ImageView mIcon2;
        public final ImageView mIconRefine;
        public final TextView mText1;
        public final TextView mText2;

        public ChildViewCache(View view) {
            this.mText1 = (TextView) view.findViewById(16908308);
            this.mText2 = (TextView) view.findViewById(16908309);
            this.mIcon1 = (ImageView) view.findViewById(16908295);
            this.mIcon2 = (ImageView) view.findViewById(16908296);
            this.mIconRefine = (ImageView) view.findViewById(R.id.edit_query);
        }
    }

    public boolean hasStableIds() {
        return false;
    }

    public SuggestionsAdapter(Context context, SearchView searchView, SearchableInfo searchableInfo, WeakHashMap<String, ConstantState> weakHashMap) {
        super(context, searchView.getSuggestionRowLayout(), null, true);
        this.mSearchView = searchView;
        this.mSearchable = searchableInfo;
        this.mCommitIconResId = searchView.getSuggestionCommitIconResId();
        this.mProviderContext = context;
        this.mOutsideDrawablesCache = weakHashMap;
    }

    public void setQueryRefinement(int i) {
        this.mQueryRefinement = i;
    }

    public int getQueryRefinement() {
        return this.mQueryRefinement;
    }

    public Cursor runQueryOnBackgroundThread(CharSequence charSequence) {
        charSequence = charSequence == null ? "" : charSequence.toString();
        if (this.mSearchView.getVisibility() == 0) {
            if (this.mSearchView.getWindowVisibility() == 0) {
                try {
                    Cursor searchManagerSuggestions = getSearchManagerSuggestions(this.mSearchable, charSequence, 50);
                    if (searchManagerSuggestions != null) {
                        searchManagerSuggestions.getCount();
                        return searchManagerSuggestions;
                    }
                } catch (Throwable e) {
                    Log.w(LOG_TAG, "Search suggestions query threw an exception.", e);
                }
                return null;
            }
        }
        return null;
    }

    public void close() {
        changeCursor(null);
        this.mClosed = true;
    }

    public void notifyDataSetChanged() {
        super.notifyDataSetChanged();
        updateSpinnerState(getCursor());
    }

    public void notifyDataSetInvalidated() {
        super.notifyDataSetInvalidated();
        updateSpinnerState(getCursor());
    }

    private void updateSpinnerState(Cursor cursor) {
        Bundle extras = cursor != null ? cursor.getExtras() : null;
        if (extras != null && !extras.getBoolean("in_progress")) {
        }
    }

    public void changeCursor(Cursor cursor) {
        if (this.mClosed) {
            Log.w(LOG_TAG, "Tried to change cursor after adapter was closed.");
            if (cursor != null) {
                cursor.close();
            }
            return;
        }
        try {
            super.changeCursor(cursor);
            if (cursor != null) {
                this.mText1Col = cursor.getColumnIndex("suggest_text_1");
                this.mText2Col = cursor.getColumnIndex("suggest_text_2");
                this.mText2UrlCol = cursor.getColumnIndex("suggest_text_2_url");
                this.mIconName1Col = cursor.getColumnIndex("suggest_icon_1");
                this.mIconName2Col = cursor.getColumnIndex("suggest_icon_2");
                this.mFlagsCol = cursor.getColumnIndex("suggest_flags");
            }
        } catch (Throwable e) {
            Log.e(LOG_TAG, "error changing cursor and caching columns", e);
        }
    }

    public View newView(Context context, Cursor cursor, ViewGroup viewGroup) {
        context = super.newView(context, cursor, viewGroup);
        context.setTag(new ChildViewCache(context));
        ((ImageView) context.findViewById(R.id.edit_query)).setImageResource(this.mCommitIconResId);
        return context;
    }

    public void bindView(View view, Context context, Cursor cursor) {
        ChildViewCache childViewCache = (ChildViewCache) view.getTag();
        context = this.mFlagsCol != -1 ? cursor.getInt(this.mFlagsCol) : null;
        if (childViewCache.mText1 != null) {
            setViewText(childViewCache.mText1, getStringOrNull(cursor, this.mText1Col));
        }
        if (childViewCache.mText2 != null) {
            CharSequence stringOrNull = getStringOrNull(cursor, this.mText2UrlCol);
            if (stringOrNull != null) {
                stringOrNull = formatUrl(stringOrNull);
            } else {
                stringOrNull = getStringOrNull(cursor, this.mText2Col);
            }
            if (TextUtils.isEmpty(stringOrNull)) {
                if (childViewCache.mText1 != null) {
                    childViewCache.mText1.setSingleLine(false);
                    childViewCache.mText1.setMaxLines(2);
                }
            } else if (childViewCache.mText1 != null) {
                childViewCache.mText1.setSingleLine(true);
                childViewCache.mText1.setMaxLines(1);
            }
            setViewText(childViewCache.mText2, stringOrNull);
        }
        if (childViewCache.mIcon1 != null) {
            setViewDrawable(childViewCache.mIcon1, getIcon1(cursor), 4);
        }
        if (childViewCache.mIcon2 != null) {
            setViewDrawable(childViewCache.mIcon2, getIcon2(cursor), 8);
        }
        if (this.mQueryRefinement != 2) {
            if (this.mQueryRefinement != 1 || (context & 1) == null) {
                childViewCache.mIconRefine.setVisibility(8);
                return;
            }
        }
        childViewCache.mIconRefine.setVisibility(0);
        childViewCache.mIconRefine.setTag(childViewCache.mText1.getText());
        childViewCache.mIconRefine.setOnClickListener(this);
    }

    public void onClick(View view) {
        view = view.getTag();
        if (view instanceof CharSequence) {
            this.mSearchView.onQueryRefine((CharSequence) view);
        }
    }

    private CharSequence formatUrl(CharSequence charSequence) {
        if (this.mUrlColor == null) {
            TypedValue typedValue = new TypedValue();
            this.mContext.getTheme().resolveAttribute(R.attr.textColorSearchUrl, typedValue, true);
            this.mUrlColor = this.mContext.getResources().getColorStateList(typedValue.resourceId);
        }
        CharSequence spannableString = new SpannableString(charSequence);
        spannableString.setSpan(new TextAppearanceSpan(null, 0, 0, this.mUrlColor, null), 0, charSequence.length(), 33);
        return spannableString;
    }

    private void setViewText(TextView textView, CharSequence charSequence) {
        textView.setText(charSequence);
        if (TextUtils.isEmpty(charSequence)) {
            textView.setVisibility(8);
        } else {
            textView.setVisibility(0);
        }
    }

    private Drawable getIcon1(Cursor cursor) {
        if (this.mIconName1Col == -1) {
            return null;
        }
        Drawable drawableFromResourceValue = getDrawableFromResourceValue(cursor.getString(this.mIconName1Col));
        if (drawableFromResourceValue != null) {
            return drawableFromResourceValue;
        }
        return getDefaultIcon1(cursor);
    }

    private Drawable getIcon2(Cursor cursor) {
        if (this.mIconName2Col == -1) {
            return null;
        }
        return getDrawableFromResourceValue(cursor.getString(this.mIconName2Col));
    }

    private void setViewDrawable(ImageView imageView, Drawable drawable, int i) {
        imageView.setImageDrawable(drawable);
        if (drawable == null) {
            imageView.setVisibility(i);
            return;
        }
        imageView.setVisibility(0);
        drawable.setVisible(false, false);
        drawable.setVisible(true, false);
    }

    public CharSequence convertToString(Cursor cursor) {
        if (cursor == null) {
            return null;
        }
        CharSequence columnString = getColumnString(cursor, "suggest_intent_query");
        if (columnString != null) {
            return columnString;
        }
        if (this.mSearchable.shouldRewriteQueryFromData()) {
            columnString = getColumnString(cursor, "suggest_intent_data");
            if (columnString != null) {
                return columnString;
            }
        }
        if (this.mSearchable.shouldRewriteQueryFromText()) {
            CharSequence columnString2 = getColumnString(cursor, "suggest_text_1");
            if (columnString2 != null) {
                return columnString2;
            }
        }
        return null;
    }

    public View getView(int i, View view, ViewGroup viewGroup) {
        try {
            return super.getView(i, view, viewGroup);
        } catch (int i2) {
            Log.w(LOG_TAG, "Search suggestions cursor threw exception.", i2);
            View newView = newView(this.mContext, this.mCursor, viewGroup);
            if (newView != null) {
                ((ChildViewCache) newView.getTag()).mText1.setText(i2.toString());
            }
            return newView;
        }
    }

    private android.graphics.drawable.Drawable getDrawableFromResourceValue(java.lang.String r5) {
        /* JADX: method processing error */
/*
Error: java.lang.NullPointerException
	at jadx.core.dex.visitors.regions.ProcessTryCatchRegions.searchTryCatchDominators(ProcessTryCatchRegions.java:75)
	at jadx.core.dex.visitors.regions.ProcessTryCatchRegions.process(ProcessTryCatchRegions.java:45)
	at jadx.core.dex.visitors.regions.RegionMakerVisitor.postProcessRegions(RegionMakerVisitor.java:63)
	at jadx.core.dex.visitors.regions.RegionMakerVisitor.visit(RegionMakerVisitor.java:58)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:31)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:17)
	at jadx.core.ProcessClass.process(ProcessClass.java:34)
	at jadx.core.ProcessClass.processDependencies(ProcessClass.java:56)
	at jadx.core.ProcessClass.process(ProcessClass.java:39)
	at jadx.api.JadxDecompiler.processClass(JadxDecompiler.java:282)
	at jadx.api.JavaClass.decompile(JavaClass.java:62)
	at jadx.api.JadxDecompiler.lambda$appendSourcesSave$0(JadxDecompiler.java:200)
*/
        /*
        r4 = this;
        r0 = 0;
        if (r5 == 0) goto L_0x0070;
    L_0x0003:
        r1 = r5.length();
        if (r1 == 0) goto L_0x0070;
    L_0x0009:
        r1 = "0";
        r1 = r1.equals(r5);
        if (r1 == 0) goto L_0x0012;
    L_0x0011:
        goto L_0x0070;
    L_0x0012:
        r1 = java.lang.Integer.parseInt(r5);	 Catch:{ NumberFormatException -> 0x005d, NotFoundException -> 0x0046 }
        r2 = new java.lang.StringBuilder;	 Catch:{ NumberFormatException -> 0x005d, NotFoundException -> 0x0046 }
        r2.<init>();	 Catch:{ NumberFormatException -> 0x005d, NotFoundException -> 0x0046 }
        r3 = "android.resource://";	 Catch:{ NumberFormatException -> 0x005d, NotFoundException -> 0x0046 }
        r2.append(r3);	 Catch:{ NumberFormatException -> 0x005d, NotFoundException -> 0x0046 }
        r3 = r4.mProviderContext;	 Catch:{ NumberFormatException -> 0x005d, NotFoundException -> 0x0046 }
        r3 = r3.getPackageName();	 Catch:{ NumberFormatException -> 0x005d, NotFoundException -> 0x0046 }
        r2.append(r3);	 Catch:{ NumberFormatException -> 0x005d, NotFoundException -> 0x0046 }
        r3 = "/";	 Catch:{ NumberFormatException -> 0x005d, NotFoundException -> 0x0046 }
        r2.append(r3);	 Catch:{ NumberFormatException -> 0x005d, NotFoundException -> 0x0046 }
        r2.append(r1);	 Catch:{ NumberFormatException -> 0x005d, NotFoundException -> 0x0046 }
        r2 = r2.toString();	 Catch:{ NumberFormatException -> 0x005d, NotFoundException -> 0x0046 }
        r3 = r4.checkIconCache(r2);	 Catch:{ NumberFormatException -> 0x005d, NotFoundException -> 0x0046 }
        if (r3 == 0) goto L_0x003c;	 Catch:{ NumberFormatException -> 0x005d, NotFoundException -> 0x0046 }
    L_0x003b:
        return r3;	 Catch:{ NumberFormatException -> 0x005d, NotFoundException -> 0x0046 }
    L_0x003c:
        r3 = r4.mProviderContext;	 Catch:{ NumberFormatException -> 0x005d, NotFoundException -> 0x0046 }
        r1 = android.support.v4.content.ContextCompat.getDrawable(r3, r1);	 Catch:{ NumberFormatException -> 0x005d, NotFoundException -> 0x0046 }
        r4.storeInIconCache(r2, r1);	 Catch:{ NumberFormatException -> 0x005d, NotFoundException -> 0x0046 }
        return r1;
    L_0x0046:
        r4 = "SuggestionsAdapter";
        r1 = new java.lang.StringBuilder;
        r1.<init>();
        r2 = "Icon resource not found: ";
        r1.append(r2);
        r1.append(r5);
        r5 = r1.toString();
        android.util.Log.w(r4, r5);
        return r0;
    L_0x005d:
        r0 = r4.checkIconCache(r5);
        if (r0 == 0) goto L_0x0064;
    L_0x0063:
        return r0;
    L_0x0064:
        r0 = android.net.Uri.parse(r5);
        r0 = r4.getDrawable(r0);
        r4.storeInIconCache(r5, r0);
        return r0;
    L_0x0070:
        return r0;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.support.v7.widget.SuggestionsAdapter.getDrawableFromResourceValue(java.lang.String):android.graphics.drawable.Drawable");
    }

    private android.graphics.drawable.Drawable getDrawable(android.net.Uri r6) {
        /* JADX: method processing error */
/*
Error: java.lang.NullPointerException
	at jadx.core.dex.visitors.regions.ProcessTryCatchRegions.searchTryCatchDominators(ProcessTryCatchRegions.java:75)
	at jadx.core.dex.visitors.regions.ProcessTryCatchRegions.process(ProcessTryCatchRegions.java:45)
	at jadx.core.dex.visitors.regions.RegionMakerVisitor.postProcessRegions(RegionMakerVisitor.java:63)
	at jadx.core.dex.visitors.regions.RegionMakerVisitor.visit(RegionMakerVisitor.java:58)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:31)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:17)
	at jadx.core.ProcessClass.process(ProcessClass.java:34)
	at jadx.core.ProcessClass.processDependencies(ProcessClass.java:56)
	at jadx.core.ProcessClass.process(ProcessClass.java:39)
	at jadx.api.JadxDecompiler.processClass(JadxDecompiler.java:282)
	at jadx.api.JavaClass.decompile(JavaClass.java:62)
	at jadx.api.JadxDecompiler.lambda$appendSourcesSave$0(JadxDecompiler.java:200)
*/
        /*
        r5 = this;
        r0 = 0;
        r1 = r6.getScheme();	 Catch:{ FileNotFoundException -> 0x0089 }
        r2 = "android.resource";	 Catch:{ FileNotFoundException -> 0x0089 }
        r1 = r2.equals(r1);	 Catch:{ FileNotFoundException -> 0x0089 }
        if (r1 == 0) goto L_0x0029;
    L_0x000d:
        r5 = r5.getDrawableFromResourceUri(r6);	 Catch:{ NotFoundException -> 0x0012 }
        return r5;
    L_0x0012:
        r5 = new java.io.FileNotFoundException;	 Catch:{ FileNotFoundException -> 0x0089 }
        r1 = new java.lang.StringBuilder;	 Catch:{ FileNotFoundException -> 0x0089 }
        r1.<init>();	 Catch:{ FileNotFoundException -> 0x0089 }
        r2 = "Resource does not exist: ";	 Catch:{ FileNotFoundException -> 0x0089 }
        r1.append(r2);	 Catch:{ FileNotFoundException -> 0x0089 }
        r1.append(r6);	 Catch:{ FileNotFoundException -> 0x0089 }
        r1 = r1.toString();	 Catch:{ FileNotFoundException -> 0x0089 }
        r5.<init>(r1);	 Catch:{ FileNotFoundException -> 0x0089 }
        throw r5;	 Catch:{ FileNotFoundException -> 0x0089 }
    L_0x0029:
        r5 = r5.mProviderContext;	 Catch:{ FileNotFoundException -> 0x0089 }
        r5 = r5.getContentResolver();	 Catch:{ FileNotFoundException -> 0x0089 }
        r5 = r5.openInputStream(r6);	 Catch:{ FileNotFoundException -> 0x0089 }
        if (r5 != 0) goto L_0x004c;	 Catch:{ FileNotFoundException -> 0x0089 }
    L_0x0035:
        r5 = new java.io.FileNotFoundException;	 Catch:{ FileNotFoundException -> 0x0089 }
        r1 = new java.lang.StringBuilder;	 Catch:{ FileNotFoundException -> 0x0089 }
        r1.<init>();	 Catch:{ FileNotFoundException -> 0x0089 }
        r2 = "Failed to open ";	 Catch:{ FileNotFoundException -> 0x0089 }
        r1.append(r2);	 Catch:{ FileNotFoundException -> 0x0089 }
        r1.append(r6);	 Catch:{ FileNotFoundException -> 0x0089 }
        r1 = r1.toString();	 Catch:{ FileNotFoundException -> 0x0089 }
        r5.<init>(r1);	 Catch:{ FileNotFoundException -> 0x0089 }
        throw r5;	 Catch:{ FileNotFoundException -> 0x0089 }
    L_0x004c:
        r1 = android.graphics.drawable.Drawable.createFromStream(r5, r0);	 Catch:{ all -> 0x006c }
        r5.close();	 Catch:{ IOException -> 0x0054 }
        goto L_0x006b;
    L_0x0054:
        r5 = move-exception;
        r2 = "SuggestionsAdapter";	 Catch:{ FileNotFoundException -> 0x0089 }
        r3 = new java.lang.StringBuilder;	 Catch:{ FileNotFoundException -> 0x0089 }
        r3.<init>();	 Catch:{ FileNotFoundException -> 0x0089 }
        r4 = "Error closing icon stream for ";	 Catch:{ FileNotFoundException -> 0x0089 }
        r3.append(r4);	 Catch:{ FileNotFoundException -> 0x0089 }
        r3.append(r6);	 Catch:{ FileNotFoundException -> 0x0089 }
        r3 = r3.toString();	 Catch:{ FileNotFoundException -> 0x0089 }
        android.util.Log.e(r2, r3, r5);	 Catch:{ FileNotFoundException -> 0x0089 }
    L_0x006b:
        return r1;
    L_0x006c:
        r1 = move-exception;
        r5.close();	 Catch:{ IOException -> 0x0071 }
        goto L_0x0088;
    L_0x0071:
        r5 = move-exception;
        r2 = "SuggestionsAdapter";	 Catch:{ FileNotFoundException -> 0x0089 }
        r3 = new java.lang.StringBuilder;	 Catch:{ FileNotFoundException -> 0x0089 }
        r3.<init>();	 Catch:{ FileNotFoundException -> 0x0089 }
        r4 = "Error closing icon stream for ";	 Catch:{ FileNotFoundException -> 0x0089 }
        r3.append(r4);	 Catch:{ FileNotFoundException -> 0x0089 }
        r3.append(r6);	 Catch:{ FileNotFoundException -> 0x0089 }
        r3 = r3.toString();	 Catch:{ FileNotFoundException -> 0x0089 }
        android.util.Log.e(r2, r3, r5);	 Catch:{ FileNotFoundException -> 0x0089 }
    L_0x0088:
        throw r1;	 Catch:{ FileNotFoundException -> 0x0089 }
    L_0x0089:
        r5 = move-exception;
        r1 = "SuggestionsAdapter";
        r2 = new java.lang.StringBuilder;
        r2.<init>();
        r3 = "Icon not found: ";
        r2.append(r3);
        r2.append(r6);
        r6 = ", ";
        r2.append(r6);
        r5 = r5.getMessage();
        r2.append(r5);
        r5 = r2.toString();
        android.util.Log.w(r1, r5);
        return r0;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.support.v7.widget.SuggestionsAdapter.getDrawable(android.net.Uri):android.graphics.drawable.Drawable");
    }

    private Drawable checkIconCache(String str) {
        ConstantState constantState = (ConstantState) this.mOutsideDrawablesCache.get(str);
        if (constantState == null) {
            return null;
        }
        return constantState.newDrawable();
    }

    private void storeInIconCache(String str, Drawable drawable) {
        if (drawable != null) {
            this.mOutsideDrawablesCache.put(str, drawable.getConstantState());
        }
    }

    private Drawable getDefaultIcon1(Cursor cursor) {
        cursor = getActivityIconWithCache(this.mSearchable.getSearchActivity());
        if (cursor != null) {
            return cursor;
        }
        return this.mContext.getPackageManager().getDefaultActivityIcon();
    }

    private Drawable getActivityIconWithCache(ComponentName componentName) {
        String flattenToShortString = componentName.flattenToShortString();
        Object obj = null;
        if (this.mOutsideDrawablesCache.containsKey(flattenToShortString)) {
            Drawable newDrawable;
            ConstantState constantState = (ConstantState) this.mOutsideDrawablesCache.get(flattenToShortString);
            if (constantState != null) {
                newDrawable = constantState.newDrawable(this.mProviderContext.getResources());
            }
            return newDrawable;
        }
        componentName = getActivityIcon(componentName);
        if (componentName != null) {
            obj = componentName.getConstantState();
        }
        this.mOutsideDrawablesCache.put(flattenToShortString, obj);
        return componentName;
    }

    private Drawable getActivityIcon(ComponentName componentName) {
        PackageManager packageManager = this.mContext.getPackageManager();
        try {
            ActivityInfo activityInfo = packageManager.getActivityInfo(componentName, 128);
            int iconResource = activityInfo.getIconResource();
            if (iconResource == 0) {
                return null;
            }
            Drawable drawable = packageManager.getDrawable(componentName.getPackageName(), iconResource, activityInfo.applicationInfo);
            if (drawable != null) {
                return drawable;
            }
            String str = LOG_TAG;
            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.append("Invalid icon resource ");
            stringBuilder.append(iconResource);
            stringBuilder.append(" for ");
            stringBuilder.append(componentName.flattenToShortString());
            Log.w(str, stringBuilder.toString());
            return null;
        } catch (NameNotFoundException e) {
            Log.w(LOG_TAG, e.toString());
            return null;
        }
    }

    public static String getColumnString(Cursor cursor, String str) {
        return getStringOrNull(cursor, cursor.getColumnIndex(str));
    }

    private static String getStringOrNull(Cursor cursor, int i) {
        if (i == -1) {
            return null;
        }
        try {
            return cursor.getString(i);
        } catch (Cursor cursor2) {
            Log.e(LOG_TAG, "unexpected error retrieving valid column from cursor, did the remote process die?", cursor2);
            return null;
        }
    }

    android.graphics.drawable.Drawable getDrawableFromResourceUri(android.net.Uri r7) throws java.io.FileNotFoundException {
        /* JADX: method processing error */
/*
Error: java.lang.NullPointerException
	at jadx.core.dex.visitors.regions.ProcessTryCatchRegions.searchTryCatchDominators(ProcessTryCatchRegions.java:75)
	at jadx.core.dex.visitors.regions.ProcessTryCatchRegions.process(ProcessTryCatchRegions.java:45)
	at jadx.core.dex.visitors.regions.RegionMakerVisitor.postProcessRegions(RegionMakerVisitor.java:63)
	at jadx.core.dex.visitors.regions.RegionMakerVisitor.visit(RegionMakerVisitor.java:58)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:31)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:17)
	at jadx.core.ProcessClass.process(ProcessClass.java:34)
	at jadx.core.ProcessClass.processDependencies(ProcessClass.java:56)
	at jadx.core.ProcessClass.process(ProcessClass.java:39)
	at jadx.api.JadxDecompiler.processClass(JadxDecompiler.java:282)
	at jadx.api.JavaClass.decompile(JavaClass.java:62)
	at jadx.api.JadxDecompiler.lambda$appendSourcesSave$0(JadxDecompiler.java:200)
*/
        /*
        r6 = this;
        r0 = r7.getAuthority();
        r1 = android.text.TextUtils.isEmpty(r0);
        if (r1 == 0) goto L_0x0021;
    L_0x000a:
        r6 = new java.io.FileNotFoundException;
        r0 = new java.lang.StringBuilder;
        r0.<init>();
        r1 = "No authority: ";
        r0.append(r1);
        r0.append(r7);
        r7 = r0.toString();
        r6.<init>(r7);
        throw r6;
    L_0x0021:
        r6 = r6.mContext;	 Catch:{ NameNotFoundException -> 0x00ba }
        r6 = r6.getPackageManager();	 Catch:{ NameNotFoundException -> 0x00ba }
        r6 = r6.getResourcesForApplication(r0);	 Catch:{ NameNotFoundException -> 0x00ba }
        r1 = r7.getPathSegments();
        if (r1 != 0) goto L_0x0048;
    L_0x0031:
        r6 = new java.io.FileNotFoundException;
        r0 = new java.lang.StringBuilder;
        r0.<init>();
        r1 = "No path: ";
        r0.append(r1);
        r0.append(r7);
        r7 = r0.toString();
        r6.<init>(r7);
        throw r6;
    L_0x0048:
        r2 = r1.size();
        r3 = 0;
        r4 = 1;
        if (r2 != r4) goto L_0x0072;
    L_0x0050:
        r0 = r1.get(r3);	 Catch:{ NumberFormatException -> 0x005b }
        r0 = (java.lang.String) r0;	 Catch:{ NumberFormatException -> 0x005b }
        r0 = java.lang.Integer.parseInt(r0);	 Catch:{ NumberFormatException -> 0x005b }
        goto L_0x0085;
    L_0x005b:
        r6 = new java.io.FileNotFoundException;
        r0 = new java.lang.StringBuilder;
        r0.<init>();
        r1 = "Single path segment is not a resource ID: ";
        r0.append(r1);
        r0.append(r7);
        r7 = r0.toString();
        r6.<init>(r7);
        throw r6;
    L_0x0072:
        r5 = 2;
        if (r2 != r5) goto L_0x00a3;
    L_0x0075:
        r2 = r1.get(r4);
        r2 = (java.lang.String) r2;
        r1 = r1.get(r3);
        r1 = (java.lang.String) r1;
        r0 = r6.getIdentifier(r2, r1, r0);
    L_0x0085:
        if (r0 != 0) goto L_0x009e;
    L_0x0087:
        r6 = new java.io.FileNotFoundException;
        r0 = new java.lang.StringBuilder;
        r0.<init>();
        r1 = "No resource found for: ";
        r0.append(r1);
        r0.append(r7);
        r7 = r0.toString();
        r6.<init>(r7);
        throw r6;
    L_0x009e:
        r6 = r6.getDrawable(r0);
        return r6;
    L_0x00a3:
        r6 = new java.io.FileNotFoundException;
        r0 = new java.lang.StringBuilder;
        r0.<init>();
        r1 = "More than two path segments: ";
        r0.append(r1);
        r0.append(r7);
        r7 = r0.toString();
        r6.<init>(r7);
        throw r6;
    L_0x00ba:
        r6 = new java.io.FileNotFoundException;
        r0 = new java.lang.StringBuilder;
        r0.<init>();
        r1 = "No package found for authority: ";
        r0.append(r1);
        r0.append(r7);
        r7 = r0.toString();
        r6.<init>(r7);
        throw r6;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.support.v7.widget.SuggestionsAdapter.getDrawableFromResourceUri(android.net.Uri):android.graphics.drawable.Drawable");
    }

    Cursor getSearchManagerSuggestions(SearchableInfo searchableInfo, String str, int i) {
        String[] strArr = null;
        if (searchableInfo == null) {
            return null;
        }
        String suggestAuthority = searchableInfo.getSuggestAuthority();
        if (suggestAuthority == null) {
            return null;
        }
        Builder fragment = new Builder().scheme("content").authority(suggestAuthority).query("").fragment("");
        String suggestPath = searchableInfo.getSuggestPath();
        if (suggestPath != null) {
            fragment.appendEncodedPath(suggestPath);
        }
        fragment.appendPath("search_suggest_query");
        String suggestSelection = searchableInfo.getSuggestSelection();
        if (suggestSelection != null) {
            strArr = new String[]{str};
        } else {
            fragment.appendPath(str);
        }
        String[] strArr2 = strArr;
        if (i > 0) {
            fragment.appendQueryParameter("limit", String.valueOf(i));
        }
        return this.mContext.getContentResolver().query(fragment.build(), null, suggestSelection, strArr2, null);
    }
}
