pub const ActionType = enum {
    iam,
    scp,
    ssm,

    pub const json_field_names = .{
        .iam = "IAM",
        .scp = "SCP",
        .ssm = "SSM",
    };
};
