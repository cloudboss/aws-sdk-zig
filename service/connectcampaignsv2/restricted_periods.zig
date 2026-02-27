const RestrictedPeriod = @import("restricted_period.zig").RestrictedPeriod;

/// Restricted period config
pub const RestrictedPeriods = union(enum) {
    restricted_period_list: ?[]const RestrictedPeriod,

    pub const json_field_names = .{
        .restricted_period_list = "restrictedPeriodList",
    };
};
