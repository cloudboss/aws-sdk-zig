pub const EmbeddingIdentityType = enum {
    iam,
    quicksight,
    anonymous,

    pub const json_field_names = .{
        .iam = "IAM",
        .quicksight = "QUICKSIGHT",
        .anonymous = "ANONYMOUS",
    };
};
