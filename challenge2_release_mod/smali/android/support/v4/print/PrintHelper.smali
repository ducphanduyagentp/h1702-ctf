.class public final Landroid/support/v4/print/PrintHelper;
.super Ljava/lang/Object;
.source "PrintHelper.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/support/v4/print/PrintHelper$PrintHelperApi24Impl;,
        Landroid/support/v4/print/PrintHelper$PrintHelperApi23Impl;,
        Landroid/support/v4/print/PrintHelper$PrintHelperApi20Impl;,
        Landroid/support/v4/print/PrintHelper$PrintHelperKitkatImpl;,
        Landroid/support/v4/print/PrintHelper$PrintHelperImpl;,
        Landroid/support/v4/print/PrintHelper$PrintHelperStubImpl;,
        Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;,
        Landroid/support/v4/print/PrintHelper$OnPrintFinishCallback;
    }
.end annotation


# static fields
.field public static final COLOR_MODE_COLOR:I = 0x2

.field public static final COLOR_MODE_MONOCHROME:I = 0x1

.field public static final ORIENTATION_LANDSCAPE:I = 0x1

.field public static final ORIENTATION_PORTRAIT:I = 0x2

.field public static final SCALE_MODE_FILL:I = 0x2

.field public static final SCALE_MODE_FIT:I = 0x1


# instance fields
.field mImpl:Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    .line 269
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 270
    invoke-static {}, Landroid/support/v4/print/PrintHelper;->systemSupportsPrint()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 271
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x18

    if-lt v0, v1, :cond_0

    .line 272
    new-instance v0, Landroid/support/v4/print/PrintHelper$PrintHelperApi24Impl;

    invoke-direct {v0, p1}, Landroid/support/v4/print/PrintHelper$PrintHelperApi24Impl;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Landroid/support/v4/print/PrintHelper;->mImpl:Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;

    goto :goto_0

    .line 273
    :cond_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_1

    .line 274
    new-instance v0, Landroid/support/v4/print/PrintHelper$PrintHelperApi23Impl;

    invoke-direct {v0, p1}, Landroid/support/v4/print/PrintHelper$PrintHelperApi23Impl;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Landroid/support/v4/print/PrintHelper;->mImpl:Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;

    goto :goto_0

    .line 275
    :cond_1
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x14

    if-lt v0, v1, :cond_2

    .line 276
    new-instance v0, Landroid/support/v4/print/PrintHelper$PrintHelperApi20Impl;

    invoke-direct {v0, p1}, Landroid/support/v4/print/PrintHelper$PrintHelperApi20Impl;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Landroid/support/v4/print/PrintHelper;->mImpl:Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;

    goto :goto_0

    .line 278
    :cond_2
    new-instance v0, Landroid/support/v4/print/PrintHelper$PrintHelperKitkatImpl;

    invoke-direct {v0, p1}, Landroid/support/v4/print/PrintHelper$PrintHelperKitkatImpl;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Landroid/support/v4/print/PrintHelper;->mImpl:Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;

    goto :goto_0

    .line 281
    :cond_3
    new-instance p1, Landroid/support/v4/print/PrintHelper$PrintHelperStubImpl;

    const/4 v0, 0x0

    invoke-direct {p1, v0}, Landroid/support/v4/print/PrintHelper$PrintHelperStubImpl;-><init>(Landroid/support/v4/print/PrintHelper$1;)V

    iput-object p1, p0, Landroid/support/v4/print/PrintHelper;->mImpl:Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;

    :goto_0
    return-void
.end method

.method public static systemSupportsPrint()Z
    .locals 2

    .line 82
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-lt v0, v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method


# virtual methods
.method public getColorMode()I
    .locals 0

    .line 327
    iget-object p0, p0, Landroid/support/v4/print/PrintHelper;->mImpl:Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;

    invoke-interface {p0}, Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;->getColorMode()I

    move-result p0

    return p0
.end method

.method public getOrientation()I
    .locals 0

    .line 348
    iget-object p0, p0, Landroid/support/v4/print/PrintHelper;->mImpl:Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;

    invoke-interface {p0}, Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;->getOrientation()I

    move-result p0

    return p0
.end method

.method public getScaleMode()I
    .locals 0

    .line 305
    iget-object p0, p0, Landroid/support/v4/print/PrintHelper;->mImpl:Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;

    invoke-interface {p0}, Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;->getScaleMode()I

    move-result p0

    return p0
.end method

.method public printBitmap(Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 1

    .line 359
    iget-object p0, p0, Landroid/support/v4/print/PrintHelper;->mImpl:Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;

    const/4 v0, 0x0

    invoke-interface {p0, p1, p2, v0}, Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;->printBitmap(Ljava/lang/String;Landroid/graphics/Bitmap;Landroid/support/v4/print/PrintHelper$OnPrintFinishCallback;)V

    return-void
.end method

.method public printBitmap(Ljava/lang/String;Landroid/graphics/Bitmap;Landroid/support/v4/print/PrintHelper$OnPrintFinishCallback;)V
    .locals 0

    .line 370
    iget-object p0, p0, Landroid/support/v4/print/PrintHelper;->mImpl:Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;

    invoke-interface {p0, p1, p2, p3}, Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;->printBitmap(Ljava/lang/String;Landroid/graphics/Bitmap;Landroid/support/v4/print/PrintHelper$OnPrintFinishCallback;)V

    return-void
.end method

.method public printBitmap(Ljava/lang/String;Landroid/net/Uri;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/FileNotFoundException;
        }
    .end annotation

    .line 383
    iget-object p0, p0, Landroid/support/v4/print/PrintHelper;->mImpl:Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;

    const/4 v0, 0x0

    invoke-interface {p0, p1, p2, v0}, Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;->printBitmap(Ljava/lang/String;Landroid/net/Uri;Landroid/support/v4/print/PrintHelper$OnPrintFinishCallback;)V

    return-void
.end method

.method public printBitmap(Ljava/lang/String;Landroid/net/Uri;Landroid/support/v4/print/PrintHelper$OnPrintFinishCallback;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/FileNotFoundException;
        }
    .end annotation

    .line 398
    iget-object p0, p0, Landroid/support/v4/print/PrintHelper;->mImpl:Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;

    invoke-interface {p0, p1, p2, p3}, Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;->printBitmap(Ljava/lang/String;Landroid/net/Uri;Landroid/support/v4/print/PrintHelper$OnPrintFinishCallback;)V

    return-void
.end method

.method public setColorMode(I)V
    .locals 0

    .line 317
    iget-object p0, p0, Landroid/support/v4/print/PrintHelper;->mImpl:Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;

    invoke-interface {p0, p1}, Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;->setColorMode(I)V

    return-void
.end method

.method public setOrientation(I)V
    .locals 0

    .line 338
    iget-object p0, p0, Landroid/support/v4/print/PrintHelper;->mImpl:Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;

    invoke-interface {p0, p1}, Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;->setOrientation(I)V

    return-void
.end method

.method public setScaleMode(I)V
    .locals 0

    .line 295
    iget-object p0, p0, Landroid/support/v4/print/PrintHelper;->mImpl:Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;

    invoke-interface {p0, p1}, Landroid/support/v4/print/PrintHelper$PrintHelperVersionImpl;->setScaleMode(I)V

    return-void
.end method
