const FileSystemEndpoint = @import("file_system_endpoint.zig").FileSystemEndpoint;

/// An Amazon FSx for NetApp ONTAP file system has the following endpoints
/// that are used to access data or to manage the file system using the
/// NetApp ONTAP CLI, REST API, or NetApp SnapMirror.
pub const FileSystemEndpoints = struct {
    /// An endpoint for managing your file system by setting up NetApp SnapMirror
    /// with other ONTAP systems.
    intercluster: ?FileSystemEndpoint,

    /// An endpoint for managing your file system using the NetApp ONTAP CLI
    /// and NetApp ONTAP API.
    management: ?FileSystemEndpoint,

    pub const json_field_names = .{
        .intercluster = "Intercluster",
        .management = "Management",
    };
};
