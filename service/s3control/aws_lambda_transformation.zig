/// Lambda function used to transform objects through an Object Lambda Access
/// Point.
pub const AwsLambdaTransformation = struct {
    /// The Amazon Resource Name (ARN) of the Lambda function.
    function_arn: []const u8,

    /// Additional JSON that provides supplemental data to the Lambda function used
    /// to transform
    /// objects.
    function_payload: ?[]const u8 = null,
};
