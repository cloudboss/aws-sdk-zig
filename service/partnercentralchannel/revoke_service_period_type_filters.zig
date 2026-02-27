const ServicePeriodType = @import("service_period_type.zig").ServicePeriodType;

/// Filters specific to revoke service period handshakes.
pub const RevokeServicePeriodTypeFilters = struct {
    /// Filter by service period types.
    service_period_types: ?[]const ServicePeriodType,

    pub const json_field_names = .{
        .service_period_types = "servicePeriodTypes",
    };
};
