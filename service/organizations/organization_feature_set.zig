pub const OrganizationFeatureSet = enum {
    all,
    consolidated_billing,

    pub const json_field_names = .{
        .all = "ALL",
        .consolidated_billing = "CONSOLIDATED_BILLING",
    };
};
