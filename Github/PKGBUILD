# Maintainer: Mathieu Roberge (Techoraye) <robergem2008@gmail.com>
pkgname=gentoo-update
pkgver=0.1
pkgrel=1
pkgdesc="An update notifier & applier for Gentoo Linux"
arch=('x86_64' 'i686' 'aarch64')
url="https://github.com/Techoraye/gentoo-update"
license=('GPL3')
depends=('gcc-libs' 'glibc')
optdepends=(
	'libnotify: desktop notifications'
	'python: systray applet support'
	'python-pyqt6: full systray GUI'
	'gentoolkit: emaint command'
	'portage: package management'
)
makedepends=('cmake' 'gcc' 'make')
provides=("${pkgname}")
conflicts=("${pkgname}")
source=("${url}/archive/v${pkgver}.tar.gz")
sha256sums=('SKIP')

build() {
	cd "${pkgname}-${pkgver}"
	mkdir -p build
	cd build
	cmake ..
	make
}

package() {
	cd "${pkgname}-${pkgver}/build"
	make DESTDIR="${pkgdir}" install
	
	# Install documentation
	install -Dm644 ../README.md "${pkgdir}/usr/share/doc/${pkgname}/README.md"
	install -Dm644 ../README-fr.md "${pkgdir}/usr/share/doc/${pkgname}/README-fr.md"
	install -Dm644 ../CHANGELOG.md "${pkgdir}/usr/share/doc/${pkgname}/CHANGELOG.md"
	install -Dm644 ../LICENSE "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"
}
