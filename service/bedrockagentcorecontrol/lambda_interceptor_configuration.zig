/// The lambda configuration for the interceptor
pub const LambdaInterceptorConfiguration = struct {
    /// The arn of the lambda function to be invoked for the interceptor.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
