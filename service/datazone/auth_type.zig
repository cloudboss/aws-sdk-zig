pub const AuthType = enum {
    iam_idc,
    disabled,

    pub const json_field_names = .{
        .iam_idc = "IAM_IDC",
        .disabled = "DISABLED",
    };
};
