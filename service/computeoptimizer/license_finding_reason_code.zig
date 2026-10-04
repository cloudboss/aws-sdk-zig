const std = @import("std");

pub const LicenseFindingReasonCode = enum {
    cw_app_insights_disabled,
    cw_app_insights_error,
    license_over_provisioned,
    optimized,

    pub const json_field_names = .{
        .cw_app_insights_disabled = "InvalidCloudWatchApplicationInsightsSetup",
        .cw_app_insights_error = "CloudWatchApplicationInsightsError",
        .license_over_provisioned = "LicenseOverprovisioned",
        .optimized = "Optimized",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cw_app_insights_disabled => "InvalidCloudWatchApplicationInsightsSetup",
            .cw_app_insights_error => "CloudWatchApplicationInsightsError",
            .license_over_provisioned => "LicenseOverprovisioned",
            .optimized => "Optimized",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
