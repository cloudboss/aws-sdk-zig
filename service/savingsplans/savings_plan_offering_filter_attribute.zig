pub const SavingsPlanOfferingFilterAttribute = enum {
    region,
    instance_family,

    pub const json_field_names = .{
        .region = "region",
        .instance_family = "instanceFamily",
    };
};
