.class final Landroid/support/v4/view/ViewCompatLollipop$1;
.super Ljava/lang/Object;
.source "ViewCompatLollipop.java"

# interfaces
.implements Landroid/view/View$OnApplyWindowInsetsListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroid/support/v4/view/ViewCompatLollipop;->setOnApplyWindowInsetsListener(Landroid/view/View;Landroid/support/v4/view/ViewCompatLollipop$OnApplyWindowInsetsListenerBridge;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic val$bridge:Landroid/support/v4/view/ViewCompatLollipop$OnApplyWindowInsetsListenerBridge;


# direct methods
.method constructor <init>(Landroid/support/v4/view/ViewCompatLollipop$OnApplyWindowInsetsListenerBridge;)V
    .locals 0

    .line 73
    iput-object p1, p0, Landroid/support/v4/view/ViewCompatLollipop$1;->val$bridge:Landroid/support/v4/view/ViewCompatLollipop$OnApplyWindowInsetsListenerBridge;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onApplyWindowInsets(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;
    .locals 0

    .line 76
    iget-object p0, p0, Landroid/support/v4/view/ViewCompatLollipop$1;->val$bridge:Landroid/support/v4/view/ViewCompatLollipop$OnApplyWindowInsetsListenerBridge;

    invoke-interface {p0, p1, p2}, Landroid/support/v4/view/ViewCompatLollipop$OnApplyWindowInsetsListenerBridge;->onApplyWindowInsets(Landroid/view/View;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/view/WindowInsets;

    return-object p0
.end method
