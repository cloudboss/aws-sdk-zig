const ServiceUpdateStatus = @import("service_update_status.zig").ServiceUpdateStatus;

/// Update action that has yet to be processed for the corresponding apply/stop
/// request
pub const PendingModifiedServiceUpdate = struct {
    /// The unique ID of the service update
    service_update_name: ?[]const u8,

    /// The status of the service update
    status: ?ServiceUpdateStatus,

    pub const json_field_names = .{
        .service_update_name = "ServiceUpdateName",
        .status = "Status",
    };
};
