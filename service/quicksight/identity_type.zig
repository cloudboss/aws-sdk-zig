pub const IdentityType = enum {
    iam,
    quicksight,
    iam_identity_center,

    pub const json_field_names = .{
        .iam = "IAM",
        .quicksight = "QUICKSIGHT",
        .iam_identity_center = "IAM_IDENTITY_CENTER",
    };
};
