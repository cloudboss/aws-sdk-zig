pub const AssessmentDataSourceType = enum {
    sr_collector,
    manual_import,
    ads,

    pub const json_field_names = .{
        .sr_collector = "SR_COLLECTOR",
        .manual_import = "MANUAL_IMPORT",
        .ads = "ADS",
    };
};
