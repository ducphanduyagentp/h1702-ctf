.class Landroid/support/v4/print/PrintHelperApi23;
.super Landroid/support/v4/print/PrintHelperApi20;
.source "PrintHelperApi23.java"


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0x17
.end annotation

.annotation build Landroid/support/annotation/RequiresApi;
    value = 0x17
.end annotation


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0

    .line 42
    invoke-direct {p0, p1}, Landroid/support/v4/print/PrintHelperApi20;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x0

    .line 44
    iput-boolean p1, p0, Landroid/support/v4/print/PrintHelperApi23;->mIsMinMarginsHandlingCorrect:Z

    return-void
.end method


# virtual methods
.method protected copyAttributes(Landroid/print/PrintAttributes;)Landroid/print/PrintAttributes$Builder;
    .locals 1

    .line 32
    invoke-super {p0, p1}, Landroid/support/v4/print/PrintHelperApi20;->copyAttributes(Landroid/print/PrintAttributes;)Landroid/print/PrintAttributes$Builder;

    move-result-object p0

    .line 34
    invoke-virtual {p1}, Landroid/print/PrintAttributes;->getDuplexMode()I

    move-result v0

    if-eqz v0, :cond_0

    .line 35
    invoke-virtual {p1}, Landroid/print/PrintAttributes;->getDuplexMode()I

    move-result p1

    invoke-virtual {p0, p1}, Landroid/print/PrintAttributes$Builder;->setDuplexMode(I)Landroid/print/PrintAttributes$Builder;

    :cond_0
    return-object p0
.end method
