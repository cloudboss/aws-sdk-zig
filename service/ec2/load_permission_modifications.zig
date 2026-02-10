const LoadPermissionRequest = @import("load_permission_request.zig").LoadPermissionRequest;

/// Describes modifications to the load permissions of an Amazon FPGA image
/// (AFI).
pub const LoadPermissionModifications = struct {
    /// The load permissions to add.
    add: ?[]const LoadPermissionRequest,

    /// The load permissions to remove.
    remove: ?[]const LoadPermissionRequest,
};
