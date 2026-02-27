pub const Owner = enum {
    custom_lambda,
    aws,
    custom_policy,

    pub const json_field_names = .{
        .custom_lambda = "Custom_Lambda",
        .aws = "Aws",
        .custom_policy = "Custom_Policy",
    };
};
