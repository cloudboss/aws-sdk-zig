pub const ResourceShareFeatureSet = enum {
    created_from_policy,
    promoting_to_standard,
    standard,

    pub const json_field_names = .{
        .created_from_policy = "CREATED_FROM_POLICY",
        .promoting_to_standard = "PROMOTING_TO_STANDARD",
        .standard = "STANDARD",
    };
};
