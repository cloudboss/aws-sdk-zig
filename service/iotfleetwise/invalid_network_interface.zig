const NetworkInterfaceFailureReason = @import("network_interface_failure_reason.zig").NetworkInterfaceFailureReason;

/// A reason a vehicle network interface isn't valid.
pub const InvalidNetworkInterface = struct {
    /// The ID of the interface that isn't valid.
    interface_id: ?[]const u8,

    /// A message about why the interface isn't valid.
    reason: ?NetworkInterfaceFailureReason,

    pub const json_field_names = .{
        .interface_id = "interfaceId",
        .reason = "reason",
    };
};
