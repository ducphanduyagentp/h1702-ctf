.class Landroid/support/v4/media/session/MediaSessionCompat$MediaSessionImplBase$2;
.super Ljava/lang/Object;
.source "MediaSessionCompat.java"

# interfaces
.implements Landroid/support/v4/media/session/MediaSessionCompatApi19$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroid/support/v4/media/session/MediaSessionCompat$MediaSessionImplBase;->setCallback(Landroid/support/v4/media/session/MediaSessionCompat$Callback;Landroid/os/Handler;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroid/support/v4/media/session/MediaSessionCompat$MediaSessionImplBase;


# direct methods
.method constructor <init>(Landroid/support/v4/media/session/MediaSessionCompat$MediaSessionImplBase;)V
    .locals 0

    .line 1548
    iput-object p1, p0, Landroid/support/v4/media/session/MediaSessionCompat$MediaSessionImplBase$2;->this$0:Landroid/support/v4/media/session/MediaSessionCompat$MediaSessionImplBase;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSeekTo(J)V
    .locals 0

    .line 1557
    iget-object p0, p0, Landroid/support/v4/media/session/MediaSessionCompat$MediaSessionImplBase$2;->this$0:Landroid/support/v4/media/session/MediaSessionCompat$MediaSessionImplBase;

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    const/16 p2, 0x12

    invoke-virtual {p0, p2, p1}, Landroid/support/v4/media/session/MediaSessionCompat$MediaSessionImplBase;->postToHandler(ILjava/lang/Object;)V

    return-void
.end method

.method public onSetRating(Ljava/lang/Object;)V
    .locals 1

    .line 1551
    iget-object p0, p0, Landroid/support/v4/media/session/MediaSessionCompat$MediaSessionImplBase$2;->this$0:Landroid/support/v4/media/session/MediaSessionCompat$MediaSessionImplBase;

    .line 1552
    invoke-static {p1}, Landroid/support/v4/media/RatingCompat;->fromRating(Ljava/lang/Object;)Landroid/support/v4/media/RatingCompat;

    move-result-object p1

    const/16 v0, 0x13

    .line 1551
    invoke-virtual {p0, v0, p1}, Landroid/support/v4/media/session/MediaSessionCompat$MediaSessionImplBase;->postToHandler(ILjava/lang/Object;)V

    return-void
.end method