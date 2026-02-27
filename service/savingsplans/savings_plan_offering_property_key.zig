pub const SavingsPlanOfferingPropertyKey = enum {
    region,
    instance_family,

    pub const json_field_names = .{
        .region = "REGION",
        .instance_family = "INSTANCE_FAMILY",
    };
};
