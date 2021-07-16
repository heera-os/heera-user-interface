#ifndef WINDOWSHADOW_H
#define WINDOWSHADOW_H

#include "tileset.h"

#include <KWindowShadow>
#include <KWindowShadowTile>
#include <KWindowSystem>

#include <QApplication>
#include <QMap>
#include <QObject>
#include <QPainter>
#include <QPixmap>
#include <QQmlEngine>
#include <QQmlParserStatus>
#include <QRect>
#include <QWindow>
#include <QVector>

struct ShadowParams
{
    ShadowParams() = default;

    ShadowParams(const QPoint &offset, int radius, qreal opacity):
        offset(offset),
        radius(radius),
        opacity(opacity)
    {}

    QPoint offset;
    int radius = 0;
    qreal opacity = 0;
};

struct CompositeShadowParams
{
    CompositeShadowParams() = default;

    CompositeShadowParams(
            const QPoint &offset,
            const ShadowParams &shadow1,
            const ShadowParams &shadow2)
        : offset(offset)
        , shadow1(shadow1)
        , shadow2(shadow2) {}

    bool isNone() const
    { return qMax(shadow1.radius, shadow2.radius) == 0; }

    QPoint offset;
    ShadowParams shadow1;
    ShadowParams shadow2;
};

class WindowShadow : public QObject, public QQmlParserStatus
{
    Q_OBJECT
    Q_INTERFACES(QQmlParserStatus)
    Q_PROPERTY(QWindow *view READ view WRITE setView NOTIFY viewChanged)
    Q_PROPERTY(QRect geometry READ geometry WRITE setGeometry NOTIFY geometryChanged)
    Q_PROPERTY(qreal radius READ radius WRITE setRadius NOTIFY radiusChanged)

public:
    WindowShadow(QObject *parent = nullptr) noexcept;
    ~WindowShadow() override;

    static CompositeShadowParams lookupShadowParams(int shadowSizeEnum);

    void classBegin() override;
    void componentComplete() override;

    void setView(QWindow *view);
    QWindow *view() const;

    void setGeometry(const QRect &rect);
    QRect geometry() const;

    void setRadius(qreal value);
    qreal radius() { return m_radius; }

private:
    void configureTiles();
    KWindowShadowTile::Ptr createTile(const QPixmap &);
    TileSet shadowTiles();

    QMargins shadowMargins(TileSet) const;

signals:
    void geometryChanged();
    void enabledChanged();
    void viewChanged();
    void edgesChanged();
    void radiusChanged();

private:
    QWindow *m_view;
    QRect m_rect;
    KWindowShadow *m_shadow;
    QVector<KWindowShadowTile::Ptr> m_tile;
    TileSet m_shadowTiles;
    qreal m_radius = 10;
};

#endif