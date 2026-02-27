pub const PartitionKeyEnforcementLevel = enum {
    required,
    optional,

    pub const json_field_names = .{
        .required = "REQUIRED",
        .optional = "OPTIONAL",
    };
};
