pub const DependencyType = enum {
    lambda_layer,

    pub const json_field_names = .{
        .lambda_layer = "LambdaLayer",
    };
};
