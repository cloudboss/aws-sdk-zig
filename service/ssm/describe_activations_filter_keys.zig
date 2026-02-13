pub const DescribeActivationsFilterKeys = enum {
    activation_ids,
    default_instance_name,
    iam_role,

    pub const json_field_names = .{
        .activation_ids = "ACTIVATION_IDS",
        .default_instance_name = "DEFAULT_INSTANCE_NAME",
        .iam_role = "IAM_ROLE",
    };
};
