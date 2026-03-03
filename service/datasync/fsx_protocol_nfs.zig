const NfsMountOptions = @import("nfs_mount_options.zig").NfsMountOptions;

/// Specifies the Network File System (NFS) protocol configuration that DataSync
/// uses to access your FSx for OpenZFS file system or FSx for ONTAP file
/// system's storage virtual machine (SVM).
pub const FsxProtocolNfs = struct {
    mount_options: ?NfsMountOptions = null,

    pub const json_field_names = .{
        .mount_options = "MountOptions",
    };
};
