INSTALL_TARGET_PROCESSES = SpringBoard
DEBUG=1
THEOS_DEVICE_IP=xphone

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AdH4x

AdH4x_FILES = Tweak.x NSObject+Extras.m
AdH4x_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
