const LambdaInterceptorConfiguration = @import("lambda_interceptor_configuration.zig").LambdaInterceptorConfiguration;

/// The interceptor configuration.
pub const InterceptorConfiguration = union(enum) {
    /// The details of the lambda function used for the interceptor.
    lambda: ?LambdaInterceptorConfiguration,

    pub const json_field_names = .{
        .lambda = "lambda",
    };
};
