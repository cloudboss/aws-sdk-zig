/// The category of the finding. Possible values are:
pub const FindingCategory = enum {
    classification,
    policy,

    pub const json_field_names = .{
        .classification = "CLASSIFICATION",
        .policy = "POLICY",
    };
};
