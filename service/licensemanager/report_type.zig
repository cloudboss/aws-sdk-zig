const std = @import("std");

pub const ReportType = enum {
    license_configuration_summary_report,
    license_configuration_usage_report,
    license_asset_group_usage_report,

    pub const json_field_names = .{
        .license_configuration_summary_report = "LicenseConfigurationSummaryReport",
        .license_configuration_usage_report = "LicenseConfigurationUsageReport",
        .license_asset_group_usage_report = "LicenseAssetGroupUsageReport",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .license_configuration_summary_report => "LicenseConfigurationSummaryReport",
            .license_configuration_usage_report => "LicenseConfigurationUsageReport",
            .license_asset_group_usage_report => "LicenseAssetGroupUsageReport",
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
