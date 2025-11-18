#!/sbin/sh

log_file="/dev/kmsg"

log() {
    echo "variant-copy.sh: $1" | tee -a "$log_file"
    echo "variant-copy.sh: $1" | tee -a /tmp/recovery.log
}

umount -f -l /odm
log "/odm unmounted"
umount -f -l /vendor
log "/vendor unmounted"

variant="$(getprop ro.product.device)"

case "$variant" in
    "OP5CFBL1")
        # OnePlus ACE 3v (audi)
        rm -rf /vendor/firmware_mnt/image/*
        cp -rf /vendor/variant/audi/vendor/* /vendor
        ;;

    "OP5E93L1")
        # OnePlus NORD 4 (audi)
        rm -rf /vendor/firmware_mnt/image/*
        cp -rf /vendor/variant/audi/vendor/* /vendor
        ;;

    *)
        # Unknown variant
        log "No need to copy files for variant: $variant"
        ;;
esac

log "twrp.variant.files_copied"

resetprop twrp.variant.files_copied "1"
