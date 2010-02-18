" Vim script file
" Description:  fetch gentoo package information from gentoo-portage.com
" Author:       Gregor Uhlenheuer
" Filename:     gentoo-info.vim
" Last Change:  Do 18 Feb 2010 14:56:48 CET

let g:gentoo_portdir = '/usr/portage'

" list manipulation functions {{{

function! s:removeTill(lines, pattern) "{{{
    let l:index = 0
    for line in a:lines
        if line =~ a:pattern
            call remove(a:lines, 0, l:index)
            break
        endif
        let l:index += 1
    endfor
    return a:lines
endfunction
" }}}

function! s:removeFrom(lines, pattern) "{{{
    let l:index = 0
    for line in a:lines
        if line =~ a:pattern
            call remove(a:lines, l:index, -1)
            break
        endif
        let l:index += 1
    endfor
    return a:lines
endfunction
" }}}

" }}}

function! s:getPortageTree() "{{{
    let l:cat_file = g:gentoo_portdir . '/profiles/categories'
    if filereadable(l:cat_file)
        let s:categories = readfile(g:gentoo_portdir.'/profiles/categories')
    endif
    let s:packages = []
    for category in s:categories
        let l:pack = []
        let l:dir = g:gentoo_portdir.'/'.category
        let l:pack = split(system('find '.l:dir.' -maxdepth 1 -type d'), '\n')
        call remove(l:pack, 0)
        call extend(s:packages, l:pack)
    endfor
    call map(s:packages, 'substitute(v:val, "^.*\\/\\(\\S\\+\\)", "\\1", "")')
    call sort(s:packages)
    let s:portage_loaded = 1
endfunction
" }}}

function! s:getPackage(name) "{{{
    if a:name != ''
        if a:name =~'\S\+\/\S\+'
            return a:name
        endif
        if !exists('s:portage_loaded')
            call s:getPortageTree()
        endif
        for category in s:categories
            if isdirectory(join([g:gentoo_portdir, category, a:name], '/'))
                return category . '/' . a:name
            endif
        endfor
    endif
    return ''
endfunction
" }}}

function! s:fetchInfo(package, mode) "{{{
    let l:mode = (a:mode == 'info') ? '' : '/' . a:mode
    let l:url = 'http://gentoo-portage.com/' . a:package . l:mode
    let l:cmd = 'curl -s -f -S ' . l:url
    return s:cleanUpResult(split(system(l:cmd), '\n'), a:package, a:mode)
endfunction
" }}}

function! s:cleanUpResult(lines, package, mode) "{{{
    if len(a:lines) > 0
        let l:lines = a:lines
        let l:package = substitute(a:package, '.*\/', '', '')

        if a:mode == 'info'
            let l:lines = s:removeTill(l:lines, 'id="contentInner"')
            let l:lines = s:removeFrom(l:lines, 'id="packagetabs"')
        else
            let l:lines = s:removeTill(l:lines, 'id="packagetabs"')
            let l:lines = s:removeFrom(l:lines, 'id="footerContainer"')
            call remove(l:lines, 0, 6)
        endif

        call map(l:lines, 'substitute(v:val, "<br\\/>", "@@", "g")')
        call map(l:lines, 'substitute(v:val, "<[^>]*>", "", "g")')
        call filter(l:lines, 'v:val !~ ''View.*Download''')
        call filter(l:lines, 'v:val !~ ''^\s*$''')
        call filter(l:lines, 'v:val !~ ''Reverse\s\+''')
        call filter(l:lines, 'v:val !~ ''^\s*Screenshots\s*$''')
        call map(l:lines, 'substitute(v:val, "^\\s\\+", "", "")')
        call map(l:lines, 'substitute(v:val, "&nbsp;", " ", "g")')
        call map(l:lines, 'substitute(v:val, "^\\(Global\\|Local\\)", "\\t\\1", "")')
        call map(l:lines, 'substitute(v:val, "^".l:package, "@@&", "")')
    endif
    return l:lines
endfunction
" }}}

function! s:display(lines) "{{{
    split [GentooInfo]
    setl noreadonly modifiable nolist
    call append(0, a:lines)
    sil! %s/@@/\r/ge
    setl nomodified readonly
    nnoremap <buffer> <CR> :bd!<CR>
    call cursor(1, 1)
endfunction
" }}}

function! s:setSyntax(package) "{{{
    let l:pkg = substitute(a:package, '^\S\+\/\(\S\+\).*', '\1', '')
    setl iskeyword+=~
    setl iskeyword+=-

    syntax keyword genIStab alpha amd64 arm hppa ia64 m68k mips ppc ppc64
    syntax keyword genIStab sh sparc sparc-fbsd x86 x86-fbsd ppc-aix
    syntax keyword genIStab x86-freebsd hppa-hpux ia64-hpux x86-interix
    syntax keyword genIStab amd64-linux ia64-linux x86-linux ppc-macos
    syntax keyword genIStab x64-macos x86-macos m68k-mint sparc-solaris
    syntax keyword genIStab sparc64-solaris x64-solaris x86-solaris s390

    syntax keyword genIArch ~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc
    syntax keyword genIArch ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd ~ppc-aix
    syntax keyword genIArch ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix
    syntax keyword genIArch ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos
    syntax keyword genIArch ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris
    syntax keyword genIArch ~sparc64-solaris ~x64-solaris ~x86-solaris ~ppc64
    syntax keyword genIArch ~s390

    syntax keyword genIMask -alpha -amd64 -arm -hppa -ia64 -m68k -mips -ppc
    syntax keyword genIMask -sh -sparc -sparc-fbsd -x86 -x86-fbsd -ppc-aix
    syntax keyword genIMask -x86-freebsd -hppa-hpux -ia64-hpux -x86-interix
    syntax keyword genIMask -amd64-linux -ia64-linux -x86-linux -ppc-macos
    syntax keyword genIMask -x64-macos -x86-macos -m68k-mint -sparc-solaris
    syntax keyword genIMask -sparc64-solaris -x64-solaris -x86-solaris -ppc64
    syntax keyword genIMask -s390

    syntax keyword genIUse 16bit-indices 16bittmp 16k_voice 32bit
    syntax keyword genIUse 3G 3dfx 3dnow 3dnowext
    syntax keyword genIUse 3ds 4mb-mod 64bit R
    syntax keyword genIUse X X509 Xaw3d a-like-o
    syntax keyword genIUse a52 aac aalib abiword
    syntax keyword genIUse abook abyss accessibility acct
    syntax keyword genIUse ace acl acm acpi
    syntax keyword genIUse activefilter ada adabas addbookmarks
    syntax keyword genIUse addition additions addns addressbook
    syntax keyword genIUse admin administrator adns adplug
    syntax keyword genIUse ads aesicm aff afs
    syntax keyword genIUse aften afterimage agent agg
    syntax keyword genIUse ahbot aida aim aio
    syntax keyword genIUse akonadi alac aliaschain alisp
    syntax keyword genIUse all-options allegro alltargets alsa
    syntax keyword genIUse alt_gfx altenburgcards altivec amavis
    syntax keyword genIUse amazon amr amrnb amrr
    syntax keyword genIUse analogtv angelscript animation-rtl animgif
    syntax keyword genIUse anondel anonperm anonren anonres
    syntax keyword genIUse ansi ant anthy antlr
    syntax keyword genIUse ao aotuv apache2 apbs
    syntax keyword genIUse apcupsd api apidocs apis
    syntax keyword genIUse apm apop applet aqua
    syntax keyword genIUse aqua_theme ar archive ares
    syntax keyword genIUse arpack artist-screen arts artworkextra
    syntax keyword genIUse aruba asf asn aspell
    syntax keyword genIUse aspnet2 ass assistant astribank
    syntax keyword genIUse async asyncdns asyncns athena
    syntax keyword genIUse atm atmo atsc attachment
    syntax keyword genIUse audacious audio audiofile audioscrobbler
    syntax keyword genIUse audit augeas auth authcram
    syntax keyword genIUse authdaemond authexternal authfile authlib
    syntax keyword genIUse authonly auto-completion autoipd automap
    syntax keyword genIUse automount autoreplace autostart autotrace
    syntax keyword genIUse avahi avalon-framework avalon-logkit avantgo
    syntax keyword genIUse avfs avg awe32 ayatana
    syntax keyword genIUse background backtrace bacula-clientonly bacula-console
    syntax keyword genIUse bacula-nodir bacula-nosd badval bahamut
    syntax keyword genIUse ban banshee bash-completion bashlogger
    syntax keyword genIUse battery bazaar bbdb bcel
    syntax keyword genIUse bcmath bdf be beagle
    syntax keyword genIUse beanshell bee beeper berkdb
    syntax keyword genIUse bgpclassless bidi big-tables bigpatch
    syntax keyword genIUse binary binary-drivers bind bindist
    syntax keyword genIUse bineditor binfilter birdstep bitdefender
    syntax keyword genIUse bittorrent bl blas blast
    syntax keyword genIUse blender blender-game blksha1 bluetooth
    syntax keyword genIUse boehm-gc bogofilter bolddiag bonjour
    syntax keyword genIUse bonusscripts boo bookmarks boost
    syntax keyword genIUse bootstrap boundschecking bracketcompletion branding
    syntax keyword genIUse brasero breakrfc bri brltty
    syntax keyword genIUse brnet bs2b bsdpty bsf
    syntax keyword genIUse bugzilla build builder bundled-libs
    syntax keyword genIUse bundledlibevent bwscheduler bzip2 c++
    syntax keyword genIUse c3p0 cairo cal cal3d
    syntax keyword genIUse calendar canna capi caps
    syntax keyword genIUse capslib carbone_theme cardbus case
    syntax keyword genIUse catalogs cblas ccache cdb
    syntax keyword genIUse cdda cddax cddb cdf
    syntax keyword genIUse cdinstall cdio cdparanoia cdr
    syntax keyword genIUse cdrkit cdrom cdrtools cdsound
    syntax keyword genIUse cegui celt cern cg
    syntax keyword genIUse cgc cgi cgraph ch
    syntax keyword genIUse chappa charconv chardet charmap
    syntax keyword genIUse chasen checkpath cheetah chicken
    syntax keyword genIUse child-protection chipcard chm chroot
    syntax keyword genIUse ciao cifsupcall cilk cint7
    syntax keyword genIUse cisco cjk clamav clamd
    syntax keyword genIUse clamdtop clarens classic clearpasswd
    syntax keyword genIUse cleartype cli client client-only
    syntax keyword genIUse clipboard clisp cln clock
    syntax keyword genIUse clucene cluster clvm cm
    syntax keyword genIUse cmake cman cmdctrl cmdreccmdi18n
    syntax keyword genIUse cmdsubmenu cmkopt cmucl cnamefix
    syntax keyword genIUse cobalt colordiff colorpicker colors
    syntax keyword genIUse command-args commons-digester commonslogging
    syntax keyword genIUse commonsnet custom-optimization
    syntax keyword genIUse community compact compat compress
    syntax keyword genIUse compressed-lumas concurrentmodphp config-log
    syntax keyword genIUse connection-sharing
    syntax keyword genIUse console consolekit contactnotes contentcache
    syntax keyword genIUse context contracted-braille contrast contrib
    syntax keyword genIUse corba coreaudio corefonts courier
    syntax keyword genIUse cover coverage coverpage cpio
    syntax keyword genIUse cpudetection cpulimit cpusets cracklib
    syntax keyword genIUse crm114 cron crypt cscope
    syntax keyword genIUse css csv ctrlmenu ctrls
    syntax keyword genIUse ctype ctypes-python cuda cue
    syntax keyword genIUse cups cupsddk curl curlwrappers
    syntax keyword genIUse cursors custom-cflags custom-cpuopts
    syntax keyword genIUse custom-smtp-reject custreloc cutterlimit cutterqueue
    syntax keyword genIUse cuttime cvs cvsgraph cxx
    syntax keyword genIUse cydir cygnal cyrillic d
    syntax keyword genIUse daap daemon dahdi dar32
    syntax keyword genIUse dar64 das data datadir
    syntax keyword genIUse dawn db db2 dbase
    syntax keyword genIUse dbi dbm dbmaker dbox
    syntax keyword genIUse dbtool dbus dbx dc1394
    syntax keyword genIUse dcc_voice dchroot ddepgentry debug
    syntax keyword genIUse debug-bnr debug-freelist debug-malloc debug-utils
    syntax keyword genIUse debug-verbose debugger decoder-preprocessor-rules
    syntax keyword genIUse dedicated
    syntax keyword genIUse deflate dell deltimeshiftrec demangle
    syntax keyword genIUse demo demodb deprecated derby
    syntax keyword genIUse designer designer-plugin deskbar desktopglobe
    syntax keyword genIUse detex dev-doc development devfs-compat
    syntax keyword genIUse devhelp device-mapper devil devpay
    syntax keyword genIUse dga dhclient dhcp dhcpcd
    syntax keyword genIUse dht dia dict diet
    syntax keyword genIUse diffheaders digitalradio dii dillo
    syntax keyword genIUse dirac direct_blit directfb directv
    syntax keyword genIUse disableslit disabletoolbar disassembler discard-path
    syntax keyword genIUse discouraged disk-partition diskio djbfft
    syntax keyword genIUse djconsole djvu dk dkim
    syntax keyword genIUse dlopen dlz dmalloc dmraid
    syntax keyword genIUse dms dmx dnd dnotify domainkeys
    syntax keyword genIUse dnsdb dnsproxy doc docbook
    syntax keyword genIUse dolby-record-switch dolbyinrec domain-aware
    syntax keyword genIUse doomsday dosformat dot double-precision
    syntax keyword genIUse dovecot-sasl downloadorder dpmod dpms
    syntax keyword genIUse drac drawing drawspaces drbd
    syntax keyword genIUse dri drm-next drmaa dropmsg
    syntax keyword genIUse ds2490 ds9097 ds9097u dso
    syntax keyword genIUse dspam dssi dtmf dts
    syntax keyword genIUse dtvla dv dvb dvbplayer
    syntax keyword genIUse dvbsetup dvd dvdarchive dvdchapjump
    syntax keyword genIUse dvdnav dvdr dvi dvi2tty
    syntax keyword genIUse dvipdfm dvlfriendlyfnames dvlrecscriptaddon
    syntax keyword genIUse dvlvidprefer
    syntax keyword genIUse dx dxr3 dxr3-audio-denoise dynamic
    syntax keyword genIUse dynamicplugin dynscaler eap-sim easy-bindings
    syntax keyword genIUse eb ebook ecaggressive ecc
    syntax keyword genIUse eckb1 ecl eclipse ecmark
    syntax keyword genIUse ecmark2 ecmark3 ecmg2 ecsteve
    syntax keyword genIUse ecsteve2 ecwj2k edirectory edit
    syntax keyword genIUse editor eds ee eigen
    syntax keyword genIUse elf elisp elliptic em84xx
    syntax keyword genIUse emacs emacs22icons embedded embedded-fuseiso
    syntax keyword genIUse emboss emerald emf emoticon
    syntax keyword genIUse emovix empathy empress empress-bcs
    syntax keyword genIUse emulation enca enchant encode
    syntax keyword genIUse enscript eolconv epiphany epoll
    syntax keyword genIUse epos epydoc erandom ermt
    syntax keyword genIUse es es_laguiatv es_miguiatv escreen
    syntax keyword genIUse esd eselect esfq esoob
    syntax keyword genIUse espeak ethernet eu_epg eurephia
    syntax keyword genIUse eve event-callback evo ewf
    syntax keyword genIUse examples excel exceptions exchange
    syntax keyword genIUse exec exif exim exiscan
    syntax keyword genIUse exiscan-acl expat experimental extensible
    syntax keyword genIUse extensions external-ffmpeg external-fuse extra
    syntax keyword genIUse extra-algorithms extra-cardsets extra-ciphers
    syntax keyword genIUse extra-phrases
    syntax keyword genIUse extra-tools extraengine extrafilters extras
    syntax keyword genIUse f-prot f90 faac faad
    syntax keyword genIUse facebook facedetect faillog fakevim
    syntax keyword genIUse fam fame fast fastbuild
    syntax keyword genIUse fastcgi fasttrack fat fax
    syntax keyword genIUse faxonly faxpp fbcon fbcondecor
    syntax keyword genIUse fbdev fbsplash fcoe fcp
    syntax keyword genIUse fdftk festival ff-card ffcall
    syntax keyword genIUse ffmpeg fftw fi fidonet
    syntax keyword genIUse fifo figlet filepicker filter
    syntax keyword genIUse finger firebird firefox firefox3
    syntax keyword genIUse fits fix-connected-rt fixed-point fkernels
    syntax keyword genIUse flac flash flask flatfile
    syntax keyword genIUse flexresp flexresp2 flickr flite
    syntax keyword genIUse float floppy florz fltk
    syntax keyword genIUse fluidsynth flup flv fm
    syntax keyword genIUse fmod fontconfig fontforge foomaticdb
    syntax keyword genIUse fop force-cgi-redirect force-oss force-reg
    syntax keyword genIUse forcefpu fortran fortran95 fortune
    syntax keyword genIUse fping fpx fr frascend
    syntax keyword genIUse freemail freesound freetds freetext
    syntax keyword genIUse freetts freewnn frei0r frontbase
    syntax keyword genIUse frontend frost frxp ftd2xx
    syntax keyword genIUse ftdi ftp ftpd ftruncate
    syntax keyword genIUse fts3 full-test furigana fuse
    syntax keyword genIUse fusion fwdonly fwdzone g15
    syntax keyword genIUse gadu gajim galago gallery
    syntax keyword genIUse galois games gamess garmin
    syntax keyword genIUse gcdmaster gcj gcl gconf
    syntax keyword genIUse gcrypt gd gd-external gdal
    syntax keyword genIUse gdbm gdl2 gdm gdml
    syntax keyword genIUse gdu geant3 geant4 gecko
    syntax keyword genIUse gedit gencertdaily genders general
    syntax keyword genIUse genshi geoip geolocation geos
    syntax keyword genIUse gev gfortran gftp ggi
    syntax keyword genIUse ghcbootstrap gif gimp ginac
    syntax keyword genIUse git github gjdoc gkrellm
    syntax keyword genIUse glade glep glgd glib
    syntax keyword genIUse glibc-compat20 glibc-omitfp glitz global
    syntax keyword genIUse gloox glsl glut gmail
    syntax keyword genIUse gmath gml gmm gmp
    syntax keyword genIUse gmplayer gmtfull gmthigh gmtsuppl
    syntax keyword genIUse gmttria gnet gnokii gnome
    syntax keyword genIUse gnome-keyring gnome-print gnomecanvas gnomecd
    syntax keyword genIUse gnupl gnuplot gnus gnustep
    syntax keyword genIUse gnutella gnutls gocr gold
    syntax keyword genIUse google google-gadgets gopher gpac
    syntax keyword genIUse gpc gpg gphoto2 gpib
    syntax keyword genIUse gpm gprof gps grace
    syntax keyword genIUse grammar graph graphics graphite
    syntax keyword genIUse graphtft graphtft-fe graphviz grass
    syntax keyword genIUse gre gre-extreme-debug groovy groupwise
    syntax keyword genIUse grp grub gs gsf
    syntax keyword genIUse gsl gsm gstreamer gtk
    syntax keyword genIUse gtk2-perl gtkhotkey gtkhtml gtkspell
    syntax keyword genIUse gtp gts gucharmap gui
    syntax keyword genIUse guidexml guile guionly gunit
    syntax keyword genIUse gutenprint gyroscopic gzip gzip-el
    syntax keyword genIUse h224 h281 h323 hacking
    syntax keyword genIUse hal hamlib handbook hardcoded-tables
    syntax keyword genIUse hardened hardlinkcutter hardware-carrier hash
    syntax keyword genIUse hb hb2 hbci hdaps
    syntax keyword genIUse hdb-ldap hddtemp hdf hdf5
    syntax keyword genIUse hdri headless help-screen hepmc
    syntax keyword genIUse herwig hesiod heterogeneous hfs
    syntax keyword genIUse hifieq high-ints highlight highvolume
    syntax keyword genIUse hipe histman history hlapi
    syntax keyword genIUse hog host hotpixels hou
    syntax keyword genIUse howl-compat hpcups hpijs hpn
    syntax keyword genIUse hr hsieh html htmlsingle
    syntax keyword genIUse htmltidy http httpd httppower
    syntax keyword genIUse hub humanities hunspell huro
    syntax keyword genIUse hvm hwmixer hybrid hybrid-auth
    syntax keyword genIUse hyperestraier hyperspec hyphenation i18n
    syntax keyword genIUse iax ibam ibm ibmvio
    syntax keyword genIUse ical icalsrv icap-client icc
    syntax keyword genIUse ice icecast iceweasel icon
    syntax keyword genIUse icons iconv icotools icoutils
    syntax keyword genIUse icp icq icu id3
    syntax keyword genIUse id3tag id64 idb ide
    syntax keyword genIUse idea ident idle idled
    syntax keyword genIUse idn ieee1394 ifc ifp
    syntax keyword genIUse ifsession ignore-case ignore-glep31 iksemel
    syntax keyword genIUse ilbc image imagemagick imaging
    syntax keyword genIUse imap imlib immqt immqt-bc
    syntax keyword genIUse impactdebug indi infiniband infowidget
    syntax keyword genIUse inherit-graph inifile injection inkjar
    syntax keyword genIUse inline inline-init-failopen innkeywords innodb
    syntax keyword genIUse inntaggedhash inode inotify inquisitio
    syntax keyword genIUse insecure-patches int64 interbase interpreter
    syntax keyword genIUse ioctl iodbc iostats ip27
    syntax keyword genIUse ip28 ip30 ip32r10k ipafont
    syntax keyword genIUse ipalias ipc ipf-transparent ipfilter
    syntax keyword genIUse iplayer iplsrc ipod ipp
    syntax keyword genIUse iproute2 ipsec iptc iptv
    syntax keyword genIUse ipv6 ipython irc irda
    syntax keyword genIUse irixpasswd irman irrlicht is
    syntax keyword genIUse isag iscsi isdn iso14755
    syntax keyword genIUse it itcl ithreads ivr
    syntax keyword genIUse ivtv ixj j2me jabber
    syntax keyword genIUse jack jad jadetex jai
    syntax keyword genIUse jamu java java-external java5
    syntax keyword genIUse java6 javacomm javamail javascript
    syntax keyword genIUse jbig jce jde jdepend
    syntax keyword genIUse jfs jimi jingle jinja2
    syntax keyword genIUse jit jmf jms jmx
    syntax keyword genIUse jni john joinlines joystick
    syntax keyword genIUse jp jpeg jpeg2k jpgraph
    syntax keyword genIUse jsapi jsch json judy
    syntax keyword genIUse juju jumpplay justify kakasi
    syntax keyword genIUse karma kaspersky kate kdcraw
    syntax keyword genIUse kde kdecards kdeenablefinal kdehiddenvisibility
    syntax keyword genIUse kdeprefix kdevplatform kdm kdrive
    syntax keyword genIUse keepsrc kerberos kernel-helper kernel-patch
    syntax keyword genIUse kexi key-screen keyboard keyscrub
    syntax keyword genIUse kid kig-scripting kino kipi
    syntax keyword genIUse kirbybase kolab konqueror kontact
    syntax keyword genIUse kpathsea kpoll kqemu kqueue
    syntax keyword genIUse krb4 kross kvm ladspa
    syntax keyword genIUse lame langpacks lapack laptop
    syntax keyword genIUse large-domain largefile largenet largeterminal
    syntax keyword genIUse lash lasi lastfm lastfmradio
    syntax keyword genIUse latex latex3 latin1 launcher
    syntax keyword genIUse lcd lcms ldap ldap-sasl
    syntax keyword genIUse ldb ldirectord learn-mode legacyssl
    syntax keyword genIUse leim lensfun levels lfd
    syntax keyword genIUse libass libburn libcaca libdsk
    syntax keyword genIUse libeai libedit libevent libextractor
    syntax keyword genIUse libffi libgda libgig liblockfile
    syntax keyword genIUse libmms libmpd libnl libnotify
    syntax keyword genIUse libpaludis libproxy libs libsamplerate
    syntax keyword genIUse libsexy libsigsegv libssh2 libsysfs
    syntax keyword genIUse libtiger libtommath libv4l libv4l2
    syntax keyword genIUse libvirtd libvisual libwww libyaml
    syntax keyword genIUse lid lids liemikuutio lights
    syntax keyword genIUse lighttpd lilo linguas_zn_CN linux-smp-stats
    syntax keyword genIUse linuxkeys linuxthreads-tls lirc lircsettings
    syntax keyword genIUse live livebuffer livecd livejournal
    syntax keyword genIUse lj llvm llvm-gcc lm_sensors
    syntax keyword genIUse lmtp lnbshare lnbsharing lock
    syntax keyword genIUse log log4j log4p logging
    syntax keyword genIUse login-watch logitech-mouse logrotate logviewer
    syntax keyword genIUse logwatch long-double loop-aes lowmem
    syntax keyword genIUse lowres lqr lua lua-cairo
    syntax keyword genIUse lua-imlib lucene lv2 lvm
    syntax keyword genIUse lvm1 lxc lynxkeymap lyrics
    syntax keyword genIUse lyrics-screen lyx lzma lzo
    syntax keyword genIUse m17n-lib macbook mad madwifi
    syntax keyword genIUse magic mail mailbox maildir
    syntax keyword genIUse maildrop mailtrain mailwrapper mainmenuhooks
    syntax keyword genIUse make-symlinks mako management managesieve
    syntax keyword genIUse manhole mapnik maps markdown
    syntax keyword genIUse masquerade math mathml matplotlib
    syntax keyword genIUse matroska matrox max-idx-128 maxsysuid
    syntax keyword genIUse maya-shaderlibrary mayavi mbox mbrola
    syntax keyword genIUse mbx mcve md md5sum
    syntax keyword genIUse md5sum-external mdb mdnsresponder-compat meanwhile
    syntax keyword genIUse mecab mediaplayer melt mem-scramble
    syntax keyword genIUse memcache memdebug memlimit memory-cleanup
    syntax keyword genIUse memoryview menu-plugin menubar menuorg
    syntax keyword genIUse mercurial messages metalink metis
    syntax keyword genIUse metric mew mfd-rewrites mgetty
    syntax keyword genIUse mh mhash midi migemo
    syntax keyword genIUse mikmod milter mime mimencode
    syntax keyword genIUse minimal minisat minuit misdn
    syntax keyword genIUse mixer mjpeg mkl mktemp
    syntax keyword genIUse mmap mmx mmxext mng
    syntax keyword genIUse moc mod_irc mod_muc mod_pubsub
    syntax keyword genIUse mod_python mode-force mode-owner mode-paranoid
    syntax keyword genIUse modelock modemmanager modkit modperl
    syntax keyword genIUse modplug mods modules moneyplex
    syntax keyword genIUse mongrel mono monolithic monolithic-build
    syntax keyword genIUse monotone moonlight mopac7 motif
    syntax keyword genIUse mounts-check mouse mozdevelop mozdom
    syntax keyword genIUse mozembed mozilla moznocompose moznoirc
    syntax keyword genIUse moznomail moznopango moznoroaming mozsha1
    syntax keyword genIUse mp2 mp3 mp3rtp mp3tunes
    syntax keyword genIUse mp4 mpd mpe mpe-sdk
    syntax keyword genIUse mpeg mpi mpi-threads mpi_njtree
    syntax keyword genIUse mplayer mpls mpqc mpu401
    syntax keyword genIUse mrim ms-bad-proposal msn msql
    syntax keyword genIUse mssql mtp mudflap muine
    syntax keyword genIUse mule multicall multidata multilib
    syntax keyword genIUse multinetwork multipath multipleip multiplesigs
    syntax keyword genIUse multiprocess multislot multitarget multiuser
    syntax keyword genIUse munin-apache munin-dhcp munin-irc munin-squid
    syntax keyword genIUse munin-surfboard musepack music musicbrainz
    syntax keyword genIUse mvl mxdatetime mydms myghty
    syntax keyword genIUse mysql mysqli mythtv mzscheme
    syntax keyword genIUse n32 n64 na_dd na_dtv
    syntax keyword genIUse na_icons nagios-dns nagios-game nagios-ntp
    syntax keyword genIUse nagios-ping nagios-ssh nano-syntax nanoemacs
    syntax keyword genIUse nas nat native-exceptions nautilus
    syntax keyword genIUse nbd nc ncap2 ncurses
    syntax keyword genIUse neXt nelma nemesi neon
    syntax keyword genIUse net netapi netbeans netboot
    syntax keyword genIUse netcdf netclient nethack netjack
    syntax keyword genIUse netpbm netplay netserver netware
    syntax keyword genIUse network network-cron networking networkmanager
    syntax keyword genIUse new-clx new-hpcups new-interface new-login
    syntax keyword genIUse new-reg-alloc newt nextaw nfconntrack
    syntax keyword genIUse nforce2 nfqueue nfs nfsv3
    syntax keyword genIUse nfsv4 nids nis njb
    syntax keyword genIUse nl nl_wolf nls nmap
    syntax keyword genIUse nntp no no-net2 no-opts
    syntax keyword genIUse no24bpp no_gf noaudio noauthcram
    syntax keyword genIUse noauthunix nocd nocrypto-algorithms nocxx
    syntax keyword genIUse nodbms nodot nodrm noepg
    syntax keyword genIUse nogyroscopic noiplog nologin nolvmstatic
    syntax keyword genIUse nomodules nonfsv4 noopcode nopie
    syntax keyword genIUse norealanalysis norewrite normalize normalizemime
    syntax keyword genIUse nosamples nosource nossp noudev
    syntax keyword genIUse nousb nousuid nova novideo
    syntax keyword genIUse nowin nowlistening noxft npp
    syntax keyword genIUse nptl nptlonly nsplugin nspr
    syntax keyword genIUse nss nsscache nssdb ntfs
    syntax keyword genIUse ntlm ntlm_unsupported_patch ntp numa
    syntax keyword genIUse numarray numeric numpy nut
    syntax keyword genIUse nuv nvidia nvram nvtv
    syntax keyword genIUse nxclient oauth oav obex
    syntax keyword genIUse objc objc++ objc-gc ocaml
    syntax keyword genIUse ocamlduce ocamlopt ocean oci8
    syntax keyword genIUse oci8-instant-client ocrad octave odbc
    syntax keyword genIUse ode odk offensive ofono
    syntax keyword genIUse ofx ogdi ogg ogg123
    syntax keyword genIUse ogm oidentd old-daemons old-linux
    syntax keyword genIUse older-kernels-compatibility oldworld ole omega
    syntax keyword genIUse one onlyalpine onoe ons
    syntax keyword genIUse opal openal openbabel opencore-amr
    syntax keyword genIUse openct opendbx openexr openft
    syntax keyword genIUse opengl openid openinventor openipmi
    syntax keyword genIUse openmp openntpd openssl opensslcrypt
    syntax keyword genIUse openstreetmap opensync openvz operoverride
    syntax keyword genIUse operoverride-verify optimisememory optimization
    syntax keyword genIUse optimized-qmake
    syntax keyword genIUse oracle orathreads oro osc
    syntax keyword genIUse oscar osdmaxitems osdmenu osgapps
    syntax keyword genIUse osp ospfapi oss otp
    syntax keyword genIUse otr ots outline-magic outputs
    syntax keyword genIUse overlays oxygen padlock pae
    syntax keyword genIUse pager pam pam_nuauth pango
    syntax keyword genIUse paranoidmsg parcheck parentalrating pari
    syntax keyword genIUse parport parse-clocks parted passfile
    syntax keyword genIUse passthru passwd passwdqc password
    syntax keyword genIUse passwordsave pasteafter pastebin patch
    syntax keyword genIUse patented pathbar pbs pbxt
    syntax keyword genIUse pcap pcapnav pccts pcf
    syntax keyword genIUse pch pci pcm pcmcia
    syntax keyword genIUse pcntl pcre pcsc-lite pda
    syntax keyword genIUse pdf pdo per-domain perforce
    syntax keyword genIUse perfprofiling perl perl-geoipupdate perlsuid
    syntax keyword genIUse pf pf-transparent pg-intdatetime pgf
    syntax keyword genIUse phonon php phyp physfs
    syntax keyword genIUse pic pidgin pike pink
    syntax keyword genIUse pinplugin pipe pipes pixmaps
    syntax keyword genIUse pkcs11 pkinit plaintext planner
    syntax keyword genIUse plasma player plib plotutils
    syntax keyword genIUse plplot plugdouble plugins pm
    syntax keyword genIUse pm-utils pmount pmu png
    syntax keyword genIUse pnm podcast policykit poll
    syntax keyword genIUse pop pop3d poppler-data portage
    syntax keyword genIUse portaudio portmon posix postfix
    syntax keyword genIUse postgis postgres postproc postscript
    syntax keyword genIUse ppcsha1 ppds ppm ppp
    syntax keyword genIUse pppd prediction preferences prefix
    syntax keyword genIUse prefixaq pregen prelude presto
    syntax keyword genIUse preview-latex pri prime print
    syntax keyword genIUse priority privacy procmail profile
    syntax keyword genIUse profiler profiling proj projectm
    syntax keyword genIUse projectx prolog pronounce proxy
    syntax keyword genIUse ps ps3 psf pstoedit
    syntax keyword genIUse pstricks psyco pt pth
    syntax keyword genIUse publishers pulseaudio pvfs2 pvm
    syntax keyword genIUse pvr pxeserial pygments pygrub
    syntax keyword genIUse pylint pymol pysolcards pyste
    syntax keyword genIUse pythia6 pythia8 python python-bindings
    syntax keyword genIUse python3 pyx pyzord q16
    syntax keyword genIUse q32 q8 qa qalculate
    syntax keyword genIUse qd qdbm qemu qhull
    syntax keyword genIUse qmail qmail-spp qmake qmax
    syntax keyword genIUse qmmm-tinker qos qpak qq
    syntax keyword genIUse qqwry qsa qscintilla qt-dbus
    syntax keyword genIUse qt-static qt-webkit qt3 qt3support
    syntax keyword genIUse qt4 qtdesigner qtscript quarantine
    syntax keyword genIUse query-browser quicktime quota quotas
    syntax keyword genIUse quote quotes qupl qwt
    syntax keyword genIUse ra radio radius radvd
    syntax keyword genIUse raid ramfs random-index raptor
    syntax keyword genIUse rar raster ratio raw
    syntax keyword genIUse raw-font-data rawio raytracerx razor
    syntax keyword genIUse rc5 rcs rdesktop rdp
    syntax keyword genIUse re react readline readme
    syntax keyword genIUse real received recode recording
    syntax keyword genIUse redeyes redland reflection reflex
    syntax keyword genIUse regex regexp reiser4 reiserfs
    syntax keyword genIUse reload reload-error-restart relp remix
    syntax keyword genIUse remote remoteosd replaygain replication
    syntax keyword genIUse replytolist reports resid resolvconf
    syntax keyword genIUse resolver restrict restrict-javascript rewrite
    syntax keyword genIUse rfc2307 rfc822 rle roe
    syntax keyword genIUse rogue romio ropemacs rotor
    syntax keyword genIUse roundrobin rpath rpc rplay
    syntax keyword genIUse rpm rrdcgi rrdtool rsh
    syntax keyword genIUse rss rsync rtc rtf
    syntax keyword genIUse rtsp ru-dv ru-g ru-i
    syntax keyword genIUse ru-k rubberband rubrica ruby
    syntax keyword genIUse ruby-bindings rubytests run run-as-root
    syntax keyword genIUse rups s3 samba samba4
    syntax keyword genIUse sample sapdb sasl savedconfig
    syntax keyword genIUse sbc sbcl scale0tilt scanfolder
    syntax keyword genIUse scanner schedule schroedinger science
    syntax keyword genIUse scim scintilla scipy scp
    syntax keyword genIUse screen screenshot script scripting
    syntax keyword genIUse scripts scrobbler scsh scsi
    syntax keyword genIUse sctp sd2 sdb-ldap sdk
    syntax keyword genIUse sdl sdl-image sdl-sound sdlaudio
    syntax keyword genIUse se_swedb seamless-hbars seamonkey search
    syntax keyword genIUse search-screen securelink security selinux
    syntax keyword genIUse semantic semantic-desktop semanticfix sendmail
    syntax keyword genIUse sensord serial server servletapi
    syntax keyword genIUse session settime setup setup-plugin
    syntax keyword genIUse sftp sge sguil sha1
    syntax keyword genIUse sha512 shaders shadow shaper
    syntax keyword genIUse sharedext sharedmem sheep shine
    syntax keyword genIUse shm shmvideo shorten shorturl
    syntax keyword genIUse shout showlistmodes showtabbar shunnotices
    syntax keyword genIUse shutdown shutdown_rewrite sid sidebar
    syntax keyword genIUse sieve sift signature-log signatures
    syntax keyword genIUse sigsegv silc simplexml single-precision
    syntax keyword genIUse sip sipim sitemisc skey
    syntax keyword genIUse skins skk skype slabs-reassign
    syntax keyword genIUse slang slit slp smapi
    syntax keyword genIUse smartcard smartspaces smbclient smbkrb5passwd
    syntax keyword genIUse smbsharemodes smi smime smp
    syntax keyword genIUse sms smtp smux sndfile
    syntax keyword genIUse snes sni snmp snomhack
    syntax keyword genIUse soap sockets socks socks5
    syntax keyword genIUse softosd softquota solid solver
    syntax keyword genIUse song-screen songs sortrecords sou
    syntax keyword genIUse sound soundex soundextract sounds
    syntax keyword genIUse soundtouch soup source sourcecaps
    syntax keyword genIUse sourceview sox spam-auth-user spamassassin
    syntax keyword genIUse spamc-user span spandsp sparse
    syntax keyword genIUse speech speedy speex spell
    syntax keyword genIUse spf spidermonkey spl splash
    syntax keyword genIUse spoof spoof-source sql sqlite
    syntax keyword genIUse sqlite3 srp srs srt
    syntax keyword genIUse srtp srv sse sse2
    syntax keyword genIUse sse3 sse4 sse4a sse5
    syntax keyword genIUse ssh ssh1 ssl ssp
    syntax keyword genIUse ssse3 stable standalone startup-notification
    syntax keyword genIUse static static-analyzer static-libs static-ppds
    syntax keyword genIUse static_pairalign staticsocket statistics stats
    syntax keyword genIUse status stemmer stk stlport
    syntax keyword genIUse stream stroke strong-optimization stun
    syntax keyword genIUse sub subject-rewrite submenu subtitles
    syntax keyword genIUse subversion suexec suid suidcheck
    syntax keyword genIUse supernodal suphp svg svga
    syntax keyword genIUse svgz svm swat swig
    syntax keyword genIUse swipl switch_user switchtimer sybase
    syntax keyword genIUse sybase-ct sylpheed symbol-db symlink
    syntax keyword genIUse symon symux syncearly syncml
    syntax keyword genIUse sysfs syslog system-libs system-libvncserver
    syntax keyword genIUse systempreferences systray sysvipc szip
    syntax keyword genIUse t1lib tads2compiler tads3compiler taglib
    syntax keyword genIUse talkfilters tao targetbased targrey
    syntax keyword genIUse taucs tb4 tbb tcl
    syntax keyword genIUse tcp tcp-zebra tcpd tcpdump
    syntax keyword genIUse tcpmd5 tcpreplay tcpwrapper tdbtest
    syntax keyword genIUse teamarena telepathy teletext telnet
    syntax keyword genIUse templates terminal tesseract test
    syntax keyword genIUse test-framework test-programs testbed tex
    syntax keyword genIUse tex4ht texmacs text texteffect
    syntax keyword genIUse textures tftp tga tgif theme_poetter
    syntax keyword genIUse theme_avp theme_deepblue theme_deeppurple
    syntax keyword genIUse themes theora thesaurus thinkpad
    syntax keyword genIUse threads threadsafe threadsonly thumbnail
    syntax keyword genIUse thumbnails thunar thunderbird tidy
    syntax keyword genIUse tiff tilepath timercmd timerinfo
    syntax keyword genIUse timestats timezone timidity tinygui
    syntax keyword genIUse tk tlen tls tntc
    syntax keyword genIUse toilet tokenizer tokyocabinet tomsfastmath
    syntax keyword genIUse toolame toolbar toolkit-scroll-bars tools
    syntax keyword genIUse topal topicisnuhost tor tordns
    syntax keyword genIUse tos totem touchscreen tpctlir
    syntax keyword genIUse tpm tpmtok trace tracker trashquota
    syntax keyword genIUse traits transcode translator transmitter
    syntax keyword genIUse transparency transparent-proxy trash-plugin
    syntax keyword genIUse trayicon tre tremor truetype
    syntax keyword genIUse truetype-debugger trusted tslib tta
    syntax keyword genIUse tts ttxtsubs tv tv_check
    syntax keyword genIUse tv_combiner tv_pick_cgi tvtime twinserial
    syntax keyword genIUse twisted twolame type3 uclibc
    syntax keyword genIUse uclibc-compat ucs2 udev udev-acl
    syntax keyword genIUse udf udpfromto udunits ui
    syntax keyword genIUse uim uk_bleb uk_rt ultra1
    syntax keyword genIUse umfpack uml underscores unicode
    syntax keyword genIUse unique unison unit-mm unity
    syntax keyword genIUse unix98 unsupported unzip upnp
    syntax keyword genIUse ups urandom urlpicpreview usb
    syntax keyword genIUse user-homedirs userfiles userlocales usermod
    syntax keyword genIUse userpriv utempter utils uucp
    syntax keyword genIUse uudeview uuencode uuid v4l
    syntax keyword genIUse v4l2 vala valgrind validinput
    syntax keyword genIUse vamp vanilla vapigen vboxwebsrv
    syntax keyword genIUse vcd vcdinfo vcdx vchroot
    syntax keyword genIUse vda vde vdesktop vdpau
    syntax keyword genIUse vdr verse vga vhook
    syntax keyword genIUse vhosts video video_cards_nvidia videos
    syntax keyword genIUse vidix view-captcha vim vim-pager
    syntax keyword genIUse vim-syntax vim-with-x vinum vinylcontrol
    syntax keyword genIUse virtual virtual-users virtualbox vis
    syntax keyword genIUse visibility vistafree visual visualization
    syntax keyword genIUse visualizer vkontakte vlm vnc
    syntax keyword genIUse voice void-chmod volctrl volpack
    syntax keyword genIUse voodoo1 voodoo2 voodoo3 voodoo5
    syntax keyword genIUse vorbis vpb vpopmail vrml
    syntax keyword genIUse vroot vst vt vte
    syntax keyword genIUse vxml wad wareagleicon watchdog
    syntax keyword genIUse wav wavpack wcs wcwidth
    syntax keyword genIUse wddx weak-algorithms weather weather-metar
    syntax keyword genIUse weather-xoap web webcheck webdav
    syntax keyword genIUse webdav-neon webdav-serf webinterface webkit
    syntax keyword genIUse webmail webphoto webpresence websockets
    syntax keyword genIUse wicd width wifi wildcards
    syntax keyword genIUse win32codecs win64 winbind winetools
    syntax keyword genIUse winetriks wininst winpopup winscp
    syntax keyword genIUse wireshark wma wma-fixed wmf
    syntax keyword genIUse wordexp wordperfect wpd wpg
    syntax keyword genIUse wps wv2 wxwidgets wxwindows
    syntax keyword genIUse x11vnc x264 x264-static x86emu
    syntax keyword genIUse xalan xanim xatrix xattr
    syntax keyword genIUse xaw xbase xcap xcb
    syntax keyword genIUse xcf xchatdccserver xchatnogtk xcomposite
    syntax keyword genIUse xemacs xen xerces-c xetex
    syntax keyword genIUse xext xface xfce xforms
    syntax keyword genIUse xfs xft xgetdefault xhtml
    syntax keyword genIUse xim xindy xine xinerama
    syntax keyword genIUse xinetd xiph xklavier xlockrc
    syntax keyword genIUse xmame xml xmldoclet xmlpatterns
    syntax keyword genIUse xmlreader xmlrpc xmlwriter xmp
    syntax keyword genIUse xmpi xorg xorgmodule xosd
    syntax keyword genIUse xpfast xplanet xpm xprint
    syntax keyword genIUse xpsmall xqilla xrandr xrender
    syntax keyword genIUse xrootd xsbpl xscreensaver xsettings
    syntax keyword genIUse xskatcards xsl xslt xsm
    syntax keyword genIUse xspf xtended xterm xterm-color
    syntax keyword genIUse xulrunner xv xvid xvmc
    syntax keyword genIUse yaepg yahoo yandexnarod yappl
    syntax keyword genIUse yaz yiff youtube yp
    syntax keyword genIUse yv12 za zapnet zapras
    syntax keyword genIUse zaptel zemberek zephyr zeroconf
    syntax keyword genIUse zfcpdump ziffy zimagez zip
    syntax keyword genIUse zippy zlib zodb zoran
    syntax keyword genIUse zrtp zsh-completion zvbi

    exe 'syntax match genIPackage display /.*' . l:pkg . '.*/'
    syntax match genIMask display /Hard\s\+Masked/
    syntax match genIWWW display /\%(https\?:\/\/\)\?\%(www.\)\?\%([a-zA-Z0-9/_-]\+\.\)*[a-zA-Z0-9/_-]\+\.[a-z]\+\/\?/

    hi link genIArch Constant
    hi link genIStab PreProc
    hi link genIPackage Statement
    hi link genIMask Identifier
    hi link genIWWW String
    hi link genIMask Type
    hi link genIUse Constant
endfunction
" }}}

function! s:GComplete(A, L, P) "{{{
    let l:arguments = ['info', 'use', 'dep', 'rdep', 'changelog']
    if strpart(a:L, 6) =~ '^\w\+\s\+\w*$'
        return join(l:arguments, "\n")
    endif
    if !exists('s:portage_loaded')
        call s:getPortageTree()
    endif
    return join(s:packages, "\n")
endfunction
" }}}

function! GentooInfo(...) "{{{
    if a:0 < 1
        echohl ErrorMsg
        echo "Usage: GentooInfo <package> [mode]"
        echohl None
        return
    endif
    let l:package = s:getPackage(a:1)
    if l:package == ''
        echohl ErrorMsg
        echo 'Package "' . a:1 . '" not found'
        echohl None
        return
    endif
    if a:0 < 2
        call s:display(s:fetchInfo(l:package, 'info'))
    else
        call s:display(s:fetchInfo(l:package, a:2))
    endif
    call s:setSyntax(l:package)
endfunction
" }}}

com! -complete=custom,s:GComplete -nargs=+ GInfo call GentooInfo(<f-args>)
