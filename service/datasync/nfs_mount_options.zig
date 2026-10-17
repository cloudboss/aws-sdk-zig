const NfsVersion = @import("nfs_version.zig").NfsVersion;

/// Specifies how DataSync can access a location using the NFS protocol.
pub const NfsMountOptions = struct {
    /// Specifies the NFS version that you want DataSync to use when mounting your
    /// NFS
    /// share. If the server refuses to use the version specified, the task fails.
    ///
    /// You can specify the following options:
    ///
    /// * `AUTOMATIC` (default): DataSync chooses NFS version 4.1. For
    /// Amazon FSx for OpenZFS locations, DataSync first attempts to use NFS
    /// version 4.2, then falls back to version 4.1, and then to earlier versions if
    /// needed.
    ///
    /// * `NFS3`: Stateless protocol version that allows for asynchronous writes on
    /// the server.
    ///
    /// * `NFSv4_0`: Stateful, firewall-friendly protocol version that supports
    /// delegations and pseudo file systems.
    ///
    /// * `NFSv4_1`: Stateful protocol version that supports sessions, directory
    /// delegations, and parallel data processing. NFS version 4.1 also includes all
    /// features
    /// available in version 4.0.
    ///
    /// * `NFSv4_2`: Stateful protocol version that supports sparse file
    /// operations, space reservation, and server-side copy operations, in addition
    /// to all
    /// features available in version 4.1. Selecting NFS version 4.2 requires an
    /// Enhanced mode
    /// task.
    ///
    /// DataSync currently only supports NFS version 3 with Amazon FSx for NetApp
    /// ONTAP locations.
    version: ?NfsVersion = null,

    pub const json_field_names = .{
        .version = "Version",
    };
};
