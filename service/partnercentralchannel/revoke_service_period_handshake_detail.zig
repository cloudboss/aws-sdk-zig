const ServicePeriodType = @import("service_period_type.zig").ServicePeriodType;

/// Details specific to revoke service period handshakes.
pub const RevokeServicePeriodHandshakeDetail = struct {
    /// The end date of the service period being revoked.
    end_date: ?i64,

    /// The minimum number of days notice required for revocation.
    minimum_notice_days: ?[]const u8,

    /// A note explaining the reason for revoking the service period.
    note: ?[]const u8,

    /// The type of service period being revoked.
    service_period_type: ?ServicePeriodType,

    /// The start date of the service period being revoked.
    start_date: ?i64,

    pub const json_field_names = .{
        .end_date = "endDate",
        .minimum_notice_days = "minimumNoticeDays",
        .note = "note",
        .service_period_type = "servicePeriodType",
        .start_date = "startDate",
    };
};
