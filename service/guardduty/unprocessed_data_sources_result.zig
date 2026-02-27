const MalwareProtectionConfigurationResult = @import("malware_protection_configuration_result.zig").MalwareProtectionConfigurationResult;

/// Specifies the names of the data sources that couldn't be enabled.
pub const UnprocessedDataSourcesResult = struct {
    malware_protection: ?MalwareProtectionConfigurationResult,

    pub const json_field_names = .{
        .malware_protection = "MalwareProtection",
    };
};
