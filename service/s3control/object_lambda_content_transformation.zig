const AwsLambdaTransformation = @import("aws_lambda_transformation.zig").AwsLambdaTransformation;

/// A container for AwsLambdaTransformation.
pub const ObjectLambdaContentTransformation = union(enum) {
    /// A container for an Lambda function.
    aws_lambda: ?AwsLambdaTransformation,
};
