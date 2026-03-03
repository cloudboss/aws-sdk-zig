const ServicePeriodType = @import("service_period_type.zig").ServicePeriodType;

/// Filters specific to start service period handshakes.
pub const StartServicePeriodTypeFilters = struct {
    /// Filter by service period types.
    service_period_types: ?[]const ServicePeriodType = null,

    pub const json_field_names = .{
        .service_period_types = "servicePeriodTypes",
    };
};
