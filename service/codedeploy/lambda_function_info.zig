/// Information about a Lambda function specified in a deployment.
pub const LambdaFunctionInfo = struct {
    /// The version of a Lambda function that production traffic points to.
    current_version: ?[]const u8,

    /// The alias of a Lambda function. For more information, see [Lambda Function
    /// Aliases](https://docs.aws.amazon.com/lambda/latest/dg/aliases-intro.html) in
    /// the *Lambda Developer
    /// Guide*.
    function_alias: ?[]const u8,

    /// The name of a Lambda function.
    function_name: ?[]const u8,

    /// The version of a Lambda function that production traffic points to after
    /// the Lambda function is deployed.
    target_version: ?[]const u8,

    /// The percentage of production traffic that the target version of a Lambda
    /// function receives.
    target_version_weight: f64 = 0,

    pub const json_field_names = .{
        .current_version = "currentVersion",
        .function_alias = "functionAlias",
        .function_name = "functionName",
        .target_version = "targetVersion",
        .target_version_weight = "targetVersionWeight",
    };
};
