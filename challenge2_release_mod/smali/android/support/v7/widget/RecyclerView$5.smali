.class Landroid/support/v7/widget/RecyclerView$5;
.super Ljava/lang/Object;
.source "RecyclerView.java"

# interfaces
.implements Landroid/support/v7/widget/ChildHelper$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroid/support/v7/widget/RecyclerView;->initChildrenHelper()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroid/support/v7/widget/RecyclerView;


# direct methods
.method constructor <init>(Landroid/support/v7/widget/RecyclerView;)V
    .locals 0

    .line 700
    iput-object p1, p0, Landroid/support/v7/widget/RecyclerView$5;->this$0:Landroid/support/v7/widget/RecyclerView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public addView(Landroid/view/View;I)V
    .locals 1

    .line 711
    iget-object v0, p0, Landroid/support/v7/widget/RecyclerView$5;->this$0:Landroid/support/v7/widget/RecyclerView;

    invoke-virtual {v0, p1, p2}, Landroid/support/v7/widget/RecyclerView;->addView(Landroid/view/View;I)V

    .line 715
    iget-object p0, p0, Landroid/support/v7/widget/RecyclerView$5;->this$0:Landroid/support/v7/widget/RecyclerView;

    invoke-virtual {p0, p1}, Landroid/support/v7/widget/RecyclerView;->dispatchChildAttached(Landroid/view/View;)V

    return-void
.end method

.method public attachViewToParent(Landroid/view/View;ILandroid/view/ViewGroup$LayoutParams;)V
    .locals 2

    .line 760
    invoke-static {p1}, Landroid/support/v7/widget/RecyclerView;->getChildViewHolderInt(Landroid/view/View;)Landroid/support/v7/widget/RecyclerView$ViewHolder;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 762
    invoke-virtual {v0}, Landroid/support/v7/widget/RecyclerView$ViewHolder;->isTmpDetached()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {v0}, Landroid/support/v7/widget/RecyclerView$ViewHolder;->shouldIgnore()Z

    move-result v1

    if-nez v1, :cond_0

    .line 763
    new-instance p0, Ljava/lang/IllegalArgumentException;

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "Called attach on a child which is not detached: "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 769
    :cond_0
    invoke-virtual {v0}, Landroid/support/v7/widget/RecyclerView$ViewHolder;->clearTmpDetachFlag()V

    .line 771
    :cond_1
    iget-object p0, p0, Landroid/support/v7/widget/RecyclerView$5;->this$0:Landroid/support/v7/widget/RecyclerView;

    invoke-static {p0, p1, p2, p3}, Landroid/support/v7/widget/RecyclerView;->access$000(Landroid/support/v7/widget/RecyclerView;Landroid/view/View;ILandroid/view/ViewGroup$LayoutParams;)V

    return-void
.end method

.method public detachViewFromParent(I)V
    .locals 2

    .line 776
    invoke-virtual {p0, p1}, Landroid/support/v7/widget/RecyclerView$5;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 778
    invoke-static {v0}, Landroid/support/v7/widget/RecyclerView;->getChildViewHolderInt(Landroid/view/View;)Landroid/support/v7/widget/RecyclerView$ViewHolder;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 780
    invoke-virtual {v0}, Landroid/support/v7/widget/RecyclerView$ViewHolder;->isTmpDetached()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Landroid/support/v7/widget/RecyclerView$ViewHolder;->shouldIgnore()Z

    move-result v1

    if-nez v1, :cond_0

    .line 781
    new-instance p0, Ljava/lang/IllegalArgumentException;

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "called detach on an already detached child "

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_0
    const/16 v1, 0x100

    .line 787
    invoke-virtual {v0, v1}, Landroid/support/v7/widget/RecyclerView$ViewHolder;->addFlags(I)V

    .line 790
    :cond_1
    iget-object p0, p0, Landroid/support/v7/widget/RecyclerView$5;->this$0:Landroid/support/v7/widget/RecyclerView;

    invoke-static {p0, p1}, Landroid/support/v7/widget/RecyclerView;->access$100(Landroid/support/v7/widget/RecyclerView;I)V

    return-void
.end method

.method public getChildAt(I)Landroid/view/View;
    .locals 0

    .line 740
    iget-object p0, p0, Landroid/support/v7/widget/RecyclerView$5;->this$0:Landroid/support/v7/widget/RecyclerView;

    invoke-virtual {p0, p1}, Landroid/support/v7/widget/RecyclerView;->getChildAt(I)Landroid/view/View;

    move-result-object p0

    return-object p0
.end method

.method public getChildCount()I
    .locals 0

    .line 703
    iget-object p0, p0, Landroid/support/v7/widget/RecyclerView$5;->this$0:Landroid/support/v7/widget/RecyclerView;

    invoke-virtual {p0}, Landroid/support/v7/widget/RecyclerView;->getChildCount()I

    move-result p0

    return p0
.end method

.method public getChildViewHolder(Landroid/view/View;)Landroid/support/v7/widget/RecyclerView$ViewHolder;
    .locals 0

    .line 754
    invoke-static {p1}, Landroid/support/v7/widget/RecyclerView;->getChildViewHolderInt(Landroid/view/View;)Landroid/support/v7/widget/RecyclerView$ViewHolder;

    move-result-object p0

    return-object p0
.end method

.method public indexOfChild(Landroid/view/View;)I
    .locals 0

    .line 720
    iget-object p0, p0, Landroid/support/v7/widget/RecyclerView$5;->this$0:Landroid/support/v7/widget/RecyclerView;

    invoke-virtual {p0, p1}, Landroid/support/v7/widget/RecyclerView;->indexOfChild(Landroid/view/View;)I

    move-result p0

    return p0
.end method

.method public onEnteredHiddenState(Landroid/view/View;)V
    .locals 0

    .line 795
    invoke-static {p1}, Landroid/support/v7/widget/RecyclerView;->getChildViewHolderInt(Landroid/view/View;)Landroid/support/v7/widget/RecyclerView$ViewHolder;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 797
    iget-object p0, p0, Landroid/support/v7/widget/RecyclerView$5;->this$0:Landroid/support/v7/widget/RecyclerView;

    invoke-static {p1, p0}, Landroid/support/v7/widget/RecyclerView$ViewHolder;->access$200(Landroid/support/v7/widget/RecyclerView$ViewHolder;Landroid/support/v7/widget/RecyclerView;)V

    :cond_0
    return-void
.end method

.method public onLeftHiddenState(Landroid/view/View;)V
    .locals 0

    .line 803
    invoke-static {p1}, Landroid/support/v7/widget/RecyclerView;->getChildViewHolderInt(Landroid/view/View;)Landroid/support/v7/widget/RecyclerView$ViewHolder;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 805
    iget-object p0, p0, Landroid/support/v7/widget/RecyclerView$5;->this$0:Landroid/support/v7/widget/RecyclerView;

    invoke-static {p1, p0}, Landroid/support/v7/widget/RecyclerView$ViewHolder;->access$300(Landroid/support/v7/widget/RecyclerView$ViewHolder;Landroid/support/v7/widget/RecyclerView;)V

    :cond_0
    return-void
.end method

.method public removeAllViews()V
    .locals 4

    .line 745
    invoke-virtual {p0}, Landroid/support/v7/widget/RecyclerView$5;->getChildCount()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    .line 747
    iget-object v2, p0, Landroid/support/v7/widget/RecyclerView$5;->this$0:Landroid/support/v7/widget/RecyclerView;

    invoke-virtual {p0, v1}, Landroid/support/v7/widget/RecyclerView$5;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/support/v7/widget/RecyclerView;->dispatchChildDetached(Landroid/view/View;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 749
    :cond_0
    iget-object p0, p0, Landroid/support/v7/widget/RecyclerView$5;->this$0:Landroid/support/v7/widget/RecyclerView;

    invoke-virtual {p0}, Landroid/support/v7/widget/RecyclerView;->removeAllViews()V

    return-void
.end method

.method public removeViewAt(I)V
    .locals 2

    .line 725
    iget-object v0, p0, Landroid/support/v7/widget/RecyclerView$5;->this$0:Landroid/support/v7/widget/RecyclerView;

    invoke-virtual {v0, p1}, Landroid/support/v7/widget/RecyclerView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 727
    iget-object v1, p0, Landroid/support/v7/widget/RecyclerView$5;->this$0:Landroid/support/v7/widget/RecyclerView;

    invoke-virtual {v1, v0}, Landroid/support/v7/widget/RecyclerView;->dispatchChildDetached(Landroid/view/View;)V

    .line 732
    :cond_0
    iget-object p0, p0, Landroid/support/v7/widget/RecyclerView$5;->this$0:Landroid/support/v7/widget/RecyclerView;

    invoke-virtual {p0, p1}, Landroid/support/v7/widget/RecyclerView;->removeViewAt(I)V

    return-void
.end method