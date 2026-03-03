const NetworkInterfacePermissionStateCode = @import("network_interface_permission_state_code.zig").NetworkInterfacePermissionStateCode;

/// Describes the state of a network interface permission.
pub const NetworkInterfacePermissionState = struct {
    /// The state of the permission.
    state: ?NetworkInterfacePermissionStateCode = null,

    /// A status message, if applicable.
    status_message: ?[]const u8 = null,
};
