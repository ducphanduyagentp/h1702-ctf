.class Landroid/support/v4/widget/PopupMenuCompat$KitKatPopupMenuImpl;
.super Landroid/support/v4/widget/PopupMenuCompat$BasePopupMenuImpl;
.source "PopupMenuCompat.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/support/v4/widget/PopupMenuCompat;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "KitKatPopupMenuImpl"
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 46
    invoke-direct {p0}, Landroid/support/v4/widget/PopupMenuCompat$BasePopupMenuImpl;-><init>()V

    return-void
.end method


# virtual methods
.method public getDragToOpenListener(Ljava/lang/Object;)Landroid/view/View$OnTouchListener;
    .locals 0

    .line 49
    invoke-static {p1}, Landroid/support/v4/widget/PopupMenuCompatKitKat;->getDragToOpenListener(Ljava/lang/Object;)Landroid/view/View$OnTouchListener;

    move-result-object p0

    return-object p0
.end method
