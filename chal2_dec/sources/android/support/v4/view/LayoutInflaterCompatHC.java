package android.support.v4.view;

import android.annotation.TargetApi;
import android.content.Context;
import android.support.annotation.RequiresApi;
import android.util.AttributeSet;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.LayoutInflater.Factory2;
import android.view.View;
import java.lang.reflect.Field;

@TargetApi(11)
@RequiresApi(11)
class LayoutInflaterCompatHC {
    private static final String TAG = "LayoutInflaterCompatHC";
    private static boolean sCheckedField;
    private static Field sLayoutInflaterFactory2Field;

    static class FactoryWrapperHC extends FactoryWrapper implements Factory2 {
        FactoryWrapperHC(LayoutInflaterFactory layoutInflaterFactory) {
            super(layoutInflaterFactory);
        }

        public View onCreateView(View view, String str, Context context, AttributeSet attributeSet) {
            return this.mDelegateFactory.onCreateView(view, str, context, attributeSet);
        }
    }

    LayoutInflaterCompatHC() {
    }

    static void setFactory(LayoutInflater layoutInflater, LayoutInflaterFactory layoutInflaterFactory) {
        Factory2 factoryWrapperHC = layoutInflaterFactory != null ? new FactoryWrapperHC(layoutInflaterFactory) : null;
        layoutInflater.setFactory2(factoryWrapperHC);
        layoutInflaterFactory = layoutInflater.getFactory();
        if (layoutInflaterFactory instanceof Factory2) {
            forceSetFactory2(layoutInflater, (Factory2) layoutInflaterFactory);
        } else {
            forceSetFactory2(layoutInflater, factoryWrapperHC);
        }
    }

    static void forceSetFactory2(LayoutInflater layoutInflater, Factory2 factory2) {
        if (!sCheckedField) {
            try {
                sLayoutInflaterFactory2Field = LayoutInflater.class.getDeclaredField("mFactory2");
                sLayoutInflaterFactory2Field.setAccessible(true);
            } catch (Throwable e) {
                String str = TAG;
                StringBuilder stringBuilder = new StringBuilder();
                stringBuilder.append("forceSetFactory2 Could not find field 'mFactory2' on class ");
                stringBuilder.append(LayoutInflater.class.getName());
                stringBuilder.append("; inflation may have unexpected results.");
                Log.e(str, stringBuilder.toString(), e);
            }
            sCheckedField = true;
        }
        if (sLayoutInflaterFactory2Field != null) {
            try {
                sLayoutInflaterFactory2Field.set(layoutInflater, factory2);
            } catch (Factory2 factory22) {
                String str2 = TAG;
                StringBuilder stringBuilder2 = new StringBuilder();
                stringBuilder2.append("forceSetFactory2 could not set the Factory2 on LayoutInflater ");
                stringBuilder2.append(layoutInflater);
                stringBuilder2.append("; inflation may have unexpected results.");
                Log.e(str2, stringBuilder2.toString(), factory22);
            }
        }
    }
}
