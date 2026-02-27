pub const AccessDeniedReason = enum {
    iam_auth,
    directory_auth,
    data_disabled,

    pub const json_field_names = .{
        .iam_auth = "IAM_AUTH",
        .directory_auth = "DIRECTORY_AUTH",
        .data_disabled = "DATA_DISABLED",
    };
};
