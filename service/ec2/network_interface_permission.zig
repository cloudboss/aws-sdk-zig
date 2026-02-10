const InterfacePermissionType = @import("interface_permission_type.zig").InterfacePermissionType;
const NetworkInterfacePermissionState = @import("network_interface_permission_state.zig").NetworkInterfacePermissionState;

/// Describes a permission for a network interface.
pub const NetworkInterfacePermission = struct {
    /// The Amazon Web Services account ID.
    aws_account_id: ?[]const u8,

    /// The Amazon Web Services service.
    aws_service: ?[]const u8,

    /// The ID of the network interface.
    network_interface_id: ?[]const u8,

    /// The ID of the network interface permission.
    network_interface_permission_id: ?[]const u8,

    /// The type of permission.
    permission: ?InterfacePermissionType,

    /// Information about the state of the permission.
    permission_state: ?NetworkInterfacePermissionState,
};
