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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
