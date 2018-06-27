.class public Landroid/support/transition/TransitionManager;
.super Ljava/lang/Object;
.source "TransitionManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/support/transition/TransitionManager$MultiListener;
    }
.end annotation


# static fields
.field private static final LOG_TAG:Ljava/lang/String; = "TransitionManager"

.field private static sDefaultTransition:Landroid/support/transition/Transition;

.field private static sPendingTransitions:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Landroid/view/ViewGroup;",
            ">;"
        }
    .end annotation
.end field

.field private static sRunningTransitions:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/lang/ref/WeakReference<",
            "Landroid/support/v4/util/ArrayMap<",
            "Landroid/view/ViewGroup;",
            "Ljava/util/ArrayList<",
            "Landroid/support/transition/Transition;",
            ">;>;>;>;"
        }
    .end annotation
.end field


# instance fields
.field private mScenePairTransitions:Landroid/support/v4/util/ArrayMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/support/v4/util/ArrayMap<",
            "Landroid/support/transition/Scene;",
            "Landroid/support/v4/util/ArrayMap<",
            "Landroid/support/transition/Scene;",
            "Landroid/support/transition/Transition;",
            ">;>;"
        }
    .end annotation
.end field

.field private mSceneTransitions:Landroid/support/v4/util/ArrayMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/support/v4/util/ArrayMap<",
            "Landroid/support/transition/Scene;",
            "Landroid/support/transition/Transition;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 83
    new-instance v0, Landroid/support/transition/AutoTransition;

    invoke-direct {v0}, Landroid/support/transition/AutoTransition;-><init>()V

    sput-object v0, Landroid/support/transition/TransitionManager;->sDefaultTransition:Landroid/support/transition/Transition;

    .line 88
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Landroid/support/transition/TransitionManager;->sRunningTransitions:Ljava/lang/ThreadLocal;

    .line 89
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Landroid/support/transition/TransitionManager;->sPendingTransitions:Ljava/util/ArrayList;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 79
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 85
    new-instance v0, Landroid/support/v4/util/ArrayMap;

    invoke-direct {v0}, Landroid/support/v4/util/ArrayMap;-><init>()V

    iput-object v0, p0, Landroid/support/transition/TransitionManager;->mSceneTransitions:Landroid/support/v4/util/ArrayMap;

    .line 86
    new-instance v0, Landroid/support/v4/util/ArrayMap;

    invoke-direct {v0}, Landroid/support/v4/util/ArrayMap;-><init>()V

    iput-object v0, p0, Landroid/support/transition/TransitionManager;->mScenePairTransitions:Landroid/support/v4/util/ArrayMap;

    return-void
.end method

.method static synthetic access$000()Ljava/util/ArrayList;
    .locals 1

    .line 79
    sget-object v0, Landroid/support/transition/TransitionManager;->sPendingTransitions:Ljava/util/ArrayList;

    return-object v0
.end method

.method public static beginDelayedTransition(Landroid/view/ViewGroup;)V
    .locals 1
    .param p0    # Landroid/view/ViewGroup;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    const/4 v0, 0x0

    .line 373
    invoke-static {p0, v0}, Landroid/support/transition/TransitionManager;->beginDelayedTransition(Landroid/view/ViewGroup;Landroid/support/transition/Transition;)V

    return-void
.end method

.method public static beginDelayedTransition(Landroid/view/ViewGroup;Landroid/support/transition/Transition;)V
    .locals 1
    .param p0    # Landroid/view/ViewGroup;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Landroid/support/transition/Transition;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    .line 401
    sget-object v0, Landroid/support/transition/TransitionManager;->sPendingTransitions:Ljava/util/ArrayList;

    invoke-virtual {v0, p0}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p0}, Landroid/support/v4/view/ViewCompat;->isLaidOut(Landroid/view/View;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 406
    sget-object v0, Landroid/support/transition/TransitionManager;->sPendingTransitions:Ljava/util/ArrayList;

    invoke-virtual {v0, p0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    if-nez p1, :cond_0

    .line 408
    sget-object p1, Landroid/support/transition/TransitionManager;->sDefaultTransition:Landroid/support/transition/Transition;

    .line 410
    :cond_0
    invoke-virtual {p1}, Landroid/support/transition/Transition;->clone()Landroid/support/transition/Transition;

    move-result-object p1

    .line 411
    invoke-static {p0, p1}, Landroid/support/transition/TransitionManager;->sceneChangeSetup(Landroid/view/ViewGroup;Landroid/support/transition/Transition;)V

    const/4 v0, 0x0

    .line 412
    invoke-static {p0, v0}, Landroid/support/transition/Scene;->setCurrentScene(Landroid/view/View;Landroid/support/transition/Scene;)V

    .line 413
    invoke-static {p0, p1}, Landroid/support/transition/TransitionManager;->sceneChangeRunTransition(Landroid/view/ViewGroup;Landroid/support/transition/Transition;)V

    :cond_1
    return-void
.end method

.method private static changeScene(Landroid/support/transition/Scene;Landroid/support/transition/Transition;)V
    .locals 2

    .line 168
    invoke-virtual {p0}, Landroid/support/transition/Scene;->getSceneRoot()Landroid/view/ViewGroup;

    move-result-object v0

    .line 170
    sget-object v1, Landroid/support/transition/TransitionManager;->sPendingTransitions:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    if-nez p1, :cond_0

    .line 172
    invoke-virtual {p0}, Landroid/support/transition/Scene;->enter()V

    goto :goto_0

    .line 174
    :cond_0
    sget-object v1, Landroid/support/transition/TransitionManager;->sPendingTransitions:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 176
    invoke-virtual {p1}, Landroid/support/transition/Transition;->clone()Landroid/support/transition/Transition;

    move-result-object p1

    .line 177
    invoke-virtual {p1, v0}, Landroid/support/transition/Transition;->setSceneRoot(Landroid/view/ViewGroup;)Landroid/support/transition/Transition;

    .line 179
    invoke-static {v0}, Landroid/support/transition/Scene;->getCurrentScene(Landroid/view/View;)Landroid/support/transition/Scene;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 180
    invoke-virtual {v1}, Landroid/support/transition/Scene;->isCreatedFromLayoutResource()Z

    move-result v1

    if-eqz v1, :cond_1

    const/4 v1, 0x1

    .line 181
    invoke-virtual {p1, v1}, Landroid/support/transition/Transition;->setCanRemoveViews(Z)V

    .line 184
    :cond_1
    invoke-static {v0, p1}, Landroid/support/transition/TransitionManager;->sceneChangeSetup(Landroid/view/ViewGroup;Landroid/support/transition/Transition;)V

    .line 186
    invoke-virtual {p0}, Landroid/support/transition/Scene;->enter()V

    .line 188
    invoke-static {v0, p1}, Landroid/support/transition/TransitionManager;->sceneChangeRunTransition(Landroid/view/ViewGroup;Landroid/support/transition/Transition;)V

    :cond_2
    :goto_0
    return-void
.end method

.method public static endTransitions(Landroid/view/ViewGroup;)V
    .locals 3

    .line 423
    sget-object v0, Landroid/support/transition/TransitionManager;->sPendingTransitions:Ljava/util/ArrayList;

    invoke-virtual {v0, p0}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 424
    invoke-static {}, Landroid/support/transition/TransitionManager;->getRunningTransitions()Landroid/support/v4/util/ArrayMap;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/support/v4/util/ArrayMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/ArrayList;

    if-eqz v0, :cond_0

    .line 425
    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    .line 427
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, v0}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 428
    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    :goto_0
    if-ltz v0, :cond_0

    .line 429
    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/support/transition/Transition;

    .line 430
    invoke-virtual {v2, p0}, Landroid/support/transition/Transition;->forceToEnd(Landroid/view/ViewGroup;)V

    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method static getRunningTransitions()Landroid/support/v4/util/ArrayMap;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Landroid/support/v4/util/ArrayMap<",
            "Landroid/view/ViewGroup;",
            "Ljava/util/ArrayList<",
            "Landroid/support/transition/Transition;",
            ">;>;"
        }
    .end annotation

    .line 194
    sget-object v0, Landroid/support/transition/TransitionManager;->sRunningTransitions:Ljava/lang/ThreadLocal;

    .line 195
    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    .line 197
    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/support/v4/util/ArrayMap;

    if-eqz v0, :cond_0

    return-object v0

    .line 202
    :cond_0
    new-instance v0, Landroid/support/v4/util/ArrayMap;

    invoke-direct {v0}, Landroid/support/v4/util/ArrayMap;-><init>()V

    .line 203
    new-instance v1, Ljava/lang/ref/WeakReference;

    invoke-direct {v1, v0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    .line 204
    sget-object v2, Landroid/support/transition/TransitionManager;->sRunningTransitions:Ljava/lang/ThreadLocal;

    invoke-virtual {v2, v1}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    return-object v0
.end method

.method private getTransition(Landroid/support/transition/Scene;)Landroid/support/transition/Transition;
    .locals 2

    .line 138
    invoke-virtual {p1}, Landroid/support/transition/Scene;->getSceneRoot()Landroid/view/ViewGroup;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 141
    invoke-static {v0}, Landroid/support/transition/Scene;->getCurrentScene(Landroid/view/View;)Landroid/support/transition/Scene;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 143
    iget-object v1, p0, Landroid/support/transition/TransitionManager;->mScenePairTransitions:Landroid/support/v4/util/ArrayMap;

    .line 144
    invoke-virtual {v1, p1}, Landroid/support/v4/util/ArrayMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/support/v4/util/ArrayMap;

    if-eqz v1, :cond_0

    .line 146
    invoke-virtual {v1, v0}, Landroid/support/v4/util/ArrayMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/support/transition/Transition;

    if-eqz v0, :cond_0

    return-object v0

    .line 153
    :cond_0
    iget-object p0, p0, Landroid/support/transition/TransitionManager;->mSceneTransitions:Landroid/support/v4/util/ArrayMap;

    invoke-virtual {p0, p1}, Landroid/support/v4/util/ArrayMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/support/transition/Transition;

    if-eqz p0, :cond_1

    goto :goto_0

    .line 154
    :cond_1
    sget-object p0, Landroid/support/transition/TransitionManager;->sDefaultTransition:Landroid/support/transition/Transition;

    :goto_0
    return-object p0
.end method

.method public static go(Landroid/support/transition/Scene;)V
    .locals 1
    .param p0    # Landroid/support/transition/Scene;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    .line 342
    sget-object v0, Landroid/support/transition/TransitionManager;->sDefaultTransition:Landroid/support/transition/Transition;

    invoke-static {p0, v0}, Landroid/support/transition/TransitionManager;->changeScene(Landroid/support/transition/Scene;Landroid/support/transition/Transition;)V

    return-void
.end method

.method public static go(Landroid/support/transition/Scene;Landroid/support/transition/Transition;)V
    .locals 0
    .param p0    # Landroid/support/transition/Scene;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Landroid/support/transition/Transition;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    .line 360
    invoke-static {p0, p1}, Landroid/support/transition/TransitionManager;->changeScene(Landroid/support/transition/Scene;Landroid/support/transition/Transition;)V

    return-void
.end method

.method private static sceneChangeRunTransition(Landroid/view/ViewGroup;Landroid/support/transition/Transition;)V
    .locals 1

    if-eqz p1, :cond_0

    if-eqz p0, :cond_0

    .line 211
    new-instance v0, Landroid/support/transition/TransitionManager$MultiListener;

    invoke-direct {v0, p1, p0}, Landroid/support/transition/TransitionManager$MultiListener;-><init>(Landroid/support/transition/Transition;Landroid/view/ViewGroup;)V

    .line 212
    invoke-virtual {p0, v0}, Landroid/view/ViewGroup;->addOnAttachStateChangeListener(Landroid/view/View$OnAttachStateChangeListener;)V

    .line 213
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object p0

    invoke-virtual {p0, v0}, Landroid/view/ViewTreeObserver;->addOnPreDrawListener(Landroid/view/ViewTreeObserver$OnPreDrawListener;)V

    :cond_0
    return-void
.end method

.method private static sceneChangeSetup(Landroid/view/ViewGroup;Landroid/support/transition/Transition;)V
    .locals 2

    .line 302
    invoke-static {}, Landroid/support/transition/TransitionManager;->getRunningTransitions()Landroid/support/v4/util/ArrayMap;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/support/v4/util/ArrayMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/ArrayList;

    if-eqz v0, :cond_0

    .line 304
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lez v1, :cond_0

    .line 305
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/support/transition/Transition;

    .line 306
    invoke-virtual {v1, p0}, Landroid/support/transition/Transition;->pause(Landroid/view/View;)V

    goto :goto_0

    :cond_0
    if-eqz p1, :cond_1

    const/4 v0, 0x1

    .line 311
    invoke-virtual {p1, p0, v0}, Landroid/support/transition/Transition;->captureValues(Landroid/view/ViewGroup;Z)V

    .line 315
    :cond_1
    invoke-static {p0}, Landroid/support/transition/Scene;->getCurrentScene(Landroid/view/View;)Landroid/support/transition/Scene;

    move-result-object p0

    if-eqz p0, :cond_2

    .line 317
    invoke-virtual {p0}, Landroid/support/transition/Scene;->exit()V

    :cond_2
    return-void
.end method


# virtual methods
.method public setTransition(Landroid/support/transition/Scene;Landroid/support/transition/Scene;Landroid/support/transition/Transition;)V
    .locals 1
    .param p1    # Landroid/support/transition/Scene;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Landroid/support/transition/Scene;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Landroid/support/transition/Transition;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    .line 118
    iget-object v0, p0, Landroid/support/transition/TransitionManager;->mScenePairTransitions:Landroid/support/v4/util/ArrayMap;

    invoke-virtual {v0, p2}, Landroid/support/v4/util/ArrayMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/support/v4/util/ArrayMap;

    if-nez v0, :cond_0

    .line 120
    new-instance v0, Landroid/support/v4/util/ArrayMap;

    invoke-direct {v0}, Landroid/support/v4/util/ArrayMap;-><init>()V

    .line 121
    iget-object p0, p0, Landroid/support/transition/TransitionManager;->mScenePairTransitions:Landroid/support/v4/util/ArrayMap;

    invoke-virtual {p0, p2, v0}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 123
    :cond_0
    invoke-virtual {v0, p1, p3}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public setTransition(Landroid/support/transition/Scene;Landroid/support/transition/Transition;)V
    .locals 0
    .param p1    # Landroid/support/transition/Scene;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Landroid/support/transition/Transition;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    .line 101
    iget-object p0, p0, Landroid/support/transition/TransitionManager;->mSceneTransitions:Landroid/support/v4/util/ArrayMap;

    invoke-virtual {p0, p1, p2}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public transitionTo(Landroid/support/transition/Scene;)V
    .locals 0
    .param p1    # Landroid/support/transition/Scene;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    .line 332
    invoke-direct {p0, p1}, Landroid/support/transition/TransitionManager;->getTransition(Landroid/support/transition/Scene;)Landroid/support/transition/Transition;

    move-result-object p0

    invoke-static {p1, p0}, Landroid/support/transition/TransitionManager;->changeScene(Landroid/support/transition/Scene;Landroid/support/transition/Transition;)V

    return-void
.end method
