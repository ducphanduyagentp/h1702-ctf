.class Landroid/support/v4/view/KeyEventCompat$HoneycombKeyEventVersionImpl;
.super Landroid/support/v4/view/KeyEventCompat$BaseKeyEventVersionImpl;
.source "KeyEventCompat.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/support/v4/view/KeyEventCompat;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "HoneycombKeyEventVersionImpl"
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 102
    invoke-direct {p0}, Landroid/support/v4/view/KeyEventCompat$BaseKeyEventVersionImpl;-><init>()V

    return-void
.end method


# virtual methods
.method public isCtrlPressed(Landroid/view/KeyEvent;)Z
    .locals 0

    .line 120
    invoke-static {p1}, Landroid/support/v4/view/KeyEventCompatHoneycomb;->isCtrlPressed(Landroid/view/KeyEvent;)Z

    move-result p0

    return p0
.end method

.method public metaStateHasModifiers(II)Z
    .locals 0

    .line 110
    invoke-static {p1, p2}, Landroid/support/v4/view/KeyEventCompatHoneycomb;->metaStateHasModifiers(II)Z

    move-result p0

    return p0
.end method

.method public metaStateHasNoModifiers(I)Z
    .locals 0

    .line 115
    invoke-static {p1}, Landroid/support/v4/view/KeyEventCompatHoneycomb;->metaStateHasNoModifiers(I)Z

    move-result p0

    return p0
.end method

.method public normalizeMetaState(I)I
    .locals 0

    .line 105
    invoke-static {p1}, Landroid/support/v4/view/KeyEventCompatHoneycomb;->normalizeMetaState(I)I

    move-result p0

    return p0
.end method
