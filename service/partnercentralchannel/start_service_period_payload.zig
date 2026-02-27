const ServicePeriodType = @import("service_period_type.zig").ServicePeriodType;

/// Payload for start service period handshake requests.
pub const StartServicePeriodPayload = struct {
    /// The end date of the service period.
    end_date: ?i64,

    /// The minimum number of days notice required for changes.
    minimum_notice_days: ?[]const u8,

    /// A note providing additional information about the service period.
    note: ?[]const u8,

    /// The identifier of the program management account.
    program_management_account_identifier: []const u8,

    /// The type of service period being started.
    service_period_type: ServicePeriodType,

    pub const json_field_names = .{
        .end_date = "endDate",
        .minimum_notice_days = "minimumNoticeDays",
        .note = "note",
        .program_management_account_identifier = "programManagementAccountIdentifier",
        .service_period_type = "servicePeriodType",
    };
};
