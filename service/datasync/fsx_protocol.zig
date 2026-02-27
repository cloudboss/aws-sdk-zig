const FsxProtocolNfs = @import("fsx_protocol_nfs.zig").FsxProtocolNfs;
const FsxProtocolSmb = @import("fsx_protocol_smb.zig").FsxProtocolSmb;

/// Specifies the data transfer protocol that DataSync uses to access your
/// Amazon FSx file system.
pub const FsxProtocol = struct {
    /// Specifies the Network File System (NFS) protocol configuration that DataSync
    /// uses to access your FSx for OpenZFS file system or FSx for ONTAP file
    /// system's storage virtual machine (SVM).
    nfs: ?FsxProtocolNfs,

    /// Specifies the Server Message Block (SMB) protocol configuration that
    /// DataSync
    /// uses to access your FSx for ONTAP file system's SVM.
    smb: ?FsxProtocolSmb,

    pub const json_field_names = .{
        .nfs = "NFS",
        .smb = "SMB",
    };
};
