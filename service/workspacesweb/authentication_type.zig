pub const AuthenticationType = enum {
    standard,
    iam_identity_center,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .iam_identity_center = "IAM_IDENTITY_CENTER",
    };
};
