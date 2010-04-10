
# Kconfig
# instead of setting 'n', leave it blank when you disable it.
CONFIG_AUFS_BRANCH_MAX_127 = y
CONFIG_AUFS_BRANCH_MAX_511 =
CONFIG_AUFS_BRANCH_MAX_1023 =
#CONFIG_AUFS_BRANCH_MAX_32767 =
CONFIG_AUFS_HNOTIFY =
CONFIG_AUFS_EXPORT =
CONFIG_AUFS_RDU =
CONFIG_AUFS_SP_IATTR =
CONFIG_AUFS_SHWH =
CONFIG_AUFS_BR_RAMFS =
CONFIG_AUFS_BR_HFSPLUS =
CONFIG_AUFS_DEBUG = y
CONFIG_AUFS_MAGIC_SYSRQ =
CONFIG_AUFS_BDEV_LOOP =
CONFIG_AUFS_INO_T_64 =

########################################

define conf
ifdef $(1)
AUFS_DEF_CONFIG += -D$(1)
export $(1)
endif
endef

$(foreach i, BRANCH_MAX_127 BRANCH_MAX_511 BRANCH_MAX_1023 \
	BRANCH_MAX_32767 \
	HNOTIFY \
	EXPORT INO_T_64 \
	RDU \
	SP_IATTR \
	SHWH \
	BR_RAMFS \
	BR_HFSPLUS \
	DEBUG MAGIC_SYSRQ \
	BDEV_LOOP, \
	$(eval $(call conf,CONFIG_AUFS_$(i))))

########################################

ifdef CONFIG_AUFS_HNOTIFY
ifndef CONFIG_INOTIFY
$(error CONFIG_AUFS_HNOTIFY requires CONFIG_INOTIFY)
endif
endif

ifdef CONFIG_AUFS_EXPORT
ifndef CONFIG_EXPORTFS
$(error CONFIG_AUFS_EXPORT requires CONFIG_EXPORTFS)
endif
endif

ifdef CONFIG_AUFS_BR_HFSPLUS
ifndef CONFIG_HFSPLUS_FS
$(error CONFIG_AUFS_BR_HFSPLUS requires CONFIG_HFSPLUS_FS)
endif
endif

ifdef CONFIG_AUFS_MAGIC_SYSRQ
ifndef CONFIG_AUFS_DEBUG
$(error CONFIG_AUFS_MAGIC_SYSRQ requires CONFIG_AUFS_DEBUG)
endif
ifndef CONFIG_MAGIC_SYSRQ
$(error CONFIG_AUFS_MAGIC_SYSRQ requires CONFIG_MAGIC_SYSRQ)
endif
endif

ifdef CONFIG_AUFS_BDEV_LOOP
ifndef CONFIG_BLK_DEV_LOOP
$(error CONFIG_AUFS_BDEV_LOOP requires CONFIG_BLK_DEV_LOOP)
endif
endif

ifdef CONFIG_AUFS_INO_T_64
ifndef CONFIG_AUFS_EXPORT
$(error CONFIG_AUFS_INO_T_64 requires CONFIG_AUFS_EXPORT)
endif
ifdef CONFIG_64BIT
ifdef CONFIG_ALPHA
$(error ino_t on ALPHA is not 64bit)
endif
ifdef CONFIG_S390
$(error ino_t on S390 is not 64bit)
endif
else
$(error ino_t is not 64bit)
endif
endif
