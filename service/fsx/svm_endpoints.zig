const SvmEndpoint = @import("svm_endpoint.zig").SvmEndpoint;

/// An Amazon FSx for NetApp ONTAP storage virtual machine (SVM) has
/// the following endpoints that are used to access data or to manage
/// the SVM using the NetApp ONTAP CLI, REST API, or NetApp CloudManager.
pub const SvmEndpoints = struct {
    /// An endpoint for connecting using the Internet Small Computer Systems
    /// Interface (iSCSI) protocol.
    iscsi: ?SvmEndpoint = null,

    /// An endpoint for managing SVMs using the NetApp ONTAP CLI, NetApp ONTAP API,
    /// or NetApp CloudManager.
    management: ?SvmEndpoint = null,

    /// An endpoint for connecting using the Network File System (NFS) protocol.
    nfs: ?SvmEndpoint = null,

    /// An endpoint for connecting using the Server Message Block (SMB) protocol.
    smb: ?SvmEndpoint = null,

    pub const json_field_names = .{
        .iscsi = "Iscsi",
        .management = "Management",
        .nfs = "Nfs",
        .smb = "Smb",
    };
};
