# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit autotools eutils systemd git-r3

DESCRIPTION="Xorg drivers for xrdp"
HOMEPAGE="http://www.xrdp.org/"
EGIT_REPO_URI="https://github.com/neutrinolabs/xorgxrdp.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT="mirror"
IUSE="glamor"

#BDEPEND="xserver-xorg-dev, xorg-x11-server-sdk or xorg-x11-server-devel"
#RDEPEND="net-misc/xrdp:0=
RDEPEND="x11-base/xorg-server:0=
	x11-libs/libX11:0=
	glamor? ( >=x11-base/xorg-server-1.19.0 x11-libs/libdrm )"
DEPEND="${RDEPEND}
	dev-lang/nasm:0=
	net-misc/xrdp:0="

#src_install() {
#	default
#	prune_libtool_files --all
#}

#src_prepare() {
#	eautoreconf
#	eapply_user
#}

#src_configure() {
#	econf
#}

PATCHES=(
	"${FILESDIR}"/${PN}-fix-glamor.patch
	)

src_configure() {
	local myconf=(
		$(use_enable glamor)
	)

	eautoreconf
	econf "${myconf[@]}"
}

src_install() {
	default

	find "${D}" -name '*.la' -delete || die
}

