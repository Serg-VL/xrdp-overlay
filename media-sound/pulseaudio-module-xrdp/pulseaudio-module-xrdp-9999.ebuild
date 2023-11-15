# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit autotools #git-r3

DESCRIPTION="An open source Pulseaudio module for Remote Desktop Protocol server"
HOMEPAGE="http://www.xrdp.org/"
#EGIT_REPO_URI="https://github.com/neutrinolabs/pulseaudio-module-xrdp.git"

PULSE_VER="9999"
SRC_URI="
	https://github.com/neutrinolabs/pulseaudio-module-xrdp/archive/devel.zip -> pulseaudio-module-xrdp-9999.zip
	https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/archive/master/pulseaudio-master.zip
"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT="mirror"

BDEPEND="=media-sound/pulseaudio-${PULSE_VER}"
RDEPEND="=media-sound/pulseaudio-${PULSE_VER}"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

src_unpack() {
	unpack ${A}

	mv "${WORKDIR}/pulseaudio-module-xrdp-devel" "${WORKDIR}/pulseaudio-module-xrdp-9999"
}

src_prepare() {
	# don't let USE=debug adjust CFLAGS
	sed -i -e 's/-g -O0//' configure.ac || die
	pushd ../pulseaudio-master/
	eautoreconf
	popd
	eautoreconf
	eapply_user
}

src_configure() {
	pushd ../pulseaudio-master/
	econf
	popd
	local myconf=(
		PULSE_DIR=${WORKDIR}/pulseaudio-master
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	prune_libtool_files --all
}
