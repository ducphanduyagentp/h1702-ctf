.class Landroid/support/v4/widget/CompoundButtonCompat$BaseCompoundButtonCompat;
.super Ljava/lang/Object;
.source "CompoundButtonCompat.java"

# interfaces
.implements Landroid/support/v4/widget/CompoundButtonCompat$CompoundButtonCompatImpl;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/support/v4/widget/CompoundButtonCompat;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "BaseCompoundButtonCompat"
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 55
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getButtonDrawable(Landroid/widget/CompoundButton;)Landroid/graphics/drawable/Drawable;
    .locals 0

    .line 78
    invoke-static {p1}, Landroid/support/v4/widget/CompoundButtonCompatGingerbread;->getButtonDrawable(Landroid/widget/CompoundButton;)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    return-object p0
.end method

.method public getButtonTintList(Landroid/widget/CompoundButton;)Landroid/content/res/ColorStateList;
    .locals 0

    .line 63
    invoke-static {p1}, Landroid/support/v4/widget/CompoundButtonCompatGingerbread;->getButtonTintList(Landroid/widget/CompoundButton;)Landroid/content/res/ColorStateList;

    move-result-object p0

    return-object p0
.end method

.method public getButtonTintMode(Landroid/widget/CompoundButton;)Landroid/graphics/PorterDuff$Mode;
    .locals 0

    .line 73
    invoke-static {p1}, Landroid/support/v4/widget/CompoundButtonCompatGingerbread;->getButtonTintMode(Landroid/widget/CompoundButton;)Landroid/graphics/PorterDuff$Mode;

    move-result-object p0

    return-object p0
.end method

.method public setButtonTintList(Landroid/widget/CompoundButton;Landroid/content/res/ColorStateList;)V
    .locals 0

    .line 58
    invoke-static {p1, p2}, Landroid/support/v4/widget/CompoundButtonCompatGingerbread;->setButtonTintList(Landroid/widget/CompoundButton;Landroid/content/res/ColorStateList;)V

    return-void
.end method

.method public setButtonTintMode(Landroid/widget/CompoundButton;Landroid/graphics/PorterDuff$Mode;)V
    .locals 0

    .line 68
    invoke-static {p1, p2}, Landroid/support/v4/widget/CompoundButtonCompatGingerbread;->setButtonTintMode(Landroid/widget/CompoundButton;Landroid/graphics/PorterDuff$Mode;)V

    return-void
.end method