const FsxProtocolNfs = @import("fsx_protocol_nfs.zig").FsxProtocolNfs;
const FsxUpdateProtocolSmb = @import("fsx_update_protocol_smb.zig").FsxUpdateProtocolSmb;

/// Specifies the data transfer protocol that DataSync uses to access your
/// Amazon FSx file system.
///
/// You can't update the Network File System (NFS) protocol configuration for
/// FSx for ONTAP locations. DataSync currently only supports NFS version 3 with
/// this location type.
pub const FsxUpdateProtocol = struct {
    nfs: ?FsxProtocolNfs,

    /// Specifies the Server Message Block (SMB) protocol configuration that
    /// DataSync
    /// uses to access your FSx for ONTAP file system's storage virtual machine
    /// (SVM).
    smb: ?FsxUpdateProtocolSmb,

    pub const json_field_names = .{
        .nfs = "NFS",
        .smb = "SMB",
    };
};
