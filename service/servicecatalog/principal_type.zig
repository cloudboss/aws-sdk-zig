pub const PrincipalType = enum {
    iam,
    iam_pattern,

    pub const json_field_names = .{
        .iam = "IAM",
        .iam_pattern = "IAM_PATTERN",
    };
};
