# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

MY_P="terminus-${PV}"

DESCRIPTION="A terminal for a more modern age"
HOMEPAGE="https://eugeny.github.io/terminus/"
SRC_URI="
	https://github.com/Eugeny/terminus/releases/download/v${PV}/${MY_P}-linux.tar.gz -> ${P}.tar.gz
	https://github.com/ScardracS/icons/releases/download/release/terminus-icons.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="alsa cups X"

S="${WORKDIR}/${MY_P}-linux"

DEPEND="
	app-accessibility/at-spi2-atk
	app-accessibility/at-spi2-core
	dev-libs/atk
	dev-libs/nss
	alsa? ( media-libs/alsa-lib )
	cups? ( net-print/cups )
	X? (
		media-libs/mesa
		x11-libs/gdk-pixbuf
		x11-libs/gtk+
		x11-libs/libdrm
		x11-libs/libXcomposite
		x11-libs/libXdamage
		x11-libs/libXfixes
		x11-libs/libxkbcommon
		x11-libs/libXrandr
		x11-libs/libxshmfence
		x11-libs/pango
	)
"

QA_PREBUILT="/opt/terminus/*"

src_prepare(){
	default
}

src_install(){
	insinto /opt/"${PN}"
	doins -r "${S}"/*
	dosym ../../opt/"${PN}"/terminus "${EPREFIX}"/usr/bin/terminus
	fperms +x /opt/"${PN}"/terminus
	make_desktop_entry /opt/${PN}/terminus Terminus terminus Utility
	doicon ../terminus.svg
	doicon ../terminus.ico
	for i in {16,24,32,48,64,72,96,128,512}; do
		doicon -s "${i}" ../terminus-"${i}".png
	done
}
