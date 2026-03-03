const LambdaFunction = @import("lambda_function.zig").LambdaFunction;

/// The data connector.
pub const DataConnector = struct {
    /// A Boolean value that specifies whether the data connector is native to IoT
    /// TwinMaker.
    is_native: ?bool = null,

    /// The Lambda function associated with this data connector.
    lambda: ?LambdaFunction = null,

    pub const json_field_names = .{
        .is_native = "isNative",
        .lambda = "lambda",
    };
};
