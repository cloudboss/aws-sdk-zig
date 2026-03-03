const std = @import("std");

pub const HealthStatusReason = enum {
    billing_view_no_access,
    billing_view_unhealthy,
    filter_invalid,
    multi_year_historical_data_disabled,

    pub const json_field_names = .{
        .billing_view_no_access = "BILLING_VIEW_NO_ACCESS",
        .billing_view_unhealthy = "BILLING_VIEW_UNHEALTHY",
        .filter_invalid = "FILTER_INVALID",
        .multi_year_historical_data_disabled = "MULTI_YEAR_HISTORICAL_DATA_DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .billing_view_no_access => "BILLING_VIEW_NO_ACCESS",
            .billing_view_unhealthy => "BILLING_VIEW_UNHEALTHY",
            .filter_invalid => "FILTER_INVALID",
            .multi_year_historical_data_disabled => "MULTI_YEAR_HISTORICAL_DATA_DISABLED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
