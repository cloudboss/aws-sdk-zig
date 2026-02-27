const AlertManagerDefinitionStatusCode = @import("alert_manager_definition_status_code.zig").AlertManagerDefinitionStatusCode;

/// The status of the alert manager.
pub const AlertManagerDefinitionStatus = struct {
    /// The current status of the alert manager.
    status_code: AlertManagerDefinitionStatusCode,

    /// If there is a failure, the reason for the failure.
    status_reason: ?[]const u8,

    pub const json_field_names = .{
        .status_code = "statusCode",
        .status_reason = "statusReason",
    };
};
