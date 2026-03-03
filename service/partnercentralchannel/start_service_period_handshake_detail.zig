const ServicePeriodType = @import("service_period_type.zig").ServicePeriodType;

/// Details specific to start service period handshakes.
pub const StartServicePeriodHandshakeDetail = struct {
    /// The end date of the service period.
    end_date: ?i64 = null,

    /// The minimum number of days notice required for changes.
    minimum_notice_days: ?[]const u8 = null,

    /// A note providing additional information about the service period.
    note: ?[]const u8 = null,

    /// The type of service period being started.
    service_period_type: ?ServicePeriodType = null,

    /// The start date of the service period.
    start_date: ?i64 = null,

    pub const json_field_names = .{
        .end_date = "endDate",
        .minimum_notice_days = "minimumNoticeDays",
        .note = "note",
        .service_period_type = "servicePeriodType",
        .start_date = "startDate",
    };
};
