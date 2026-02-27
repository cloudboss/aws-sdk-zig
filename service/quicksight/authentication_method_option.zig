pub const AuthenticationMethodOption = enum {
    iam_and_quicksight,
    iam_only,
    active_directory,
    iam_identity_center,

    pub const json_field_names = .{
        .iam_and_quicksight = "IAM_AND_QUICKSIGHT",
        .iam_only = "IAM_ONLY",
        .active_directory = "ACTIVE_DIRECTORY",
        .iam_identity_center = "IAM_IDENTITY_CENTER",
    };
};
