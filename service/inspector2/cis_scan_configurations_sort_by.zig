pub const CisScanConfigurationsSortBy = enum {
    scan_name,
    scan_configuration_arn,

    pub const json_field_names = .{
        .scan_name = "SCAN_NAME",
        .scan_configuration_arn = "SCAN_CONFIGURATION_ARN",
    };
};
