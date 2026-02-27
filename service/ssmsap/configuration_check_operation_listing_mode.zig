pub const ConfigurationCheckOperationListingMode = enum {
    all_operations,
    latest_per_check,

    pub const json_field_names = .{
        .all_operations = "ALL_OPERATIONS",
        .latest_per_check = "LATEST_PER_CHECK",
    };
};
