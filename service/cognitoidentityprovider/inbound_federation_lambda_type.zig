const InboundFederationLambdaVersionType = @import("inbound_federation_lambda_version_type.zig").InboundFederationLambdaVersionType;

/// The properties of an inbound federation Lambda trigger.
pub const InboundFederationLambdaType = struct {
    /// The Amazon Resource Name (ARN) of the function that you want to assign to
    /// your Lambda trigger.
    lambda_arn: []const u8,

    /// The user pool trigger version of the request that Amazon Cognito sends to
    /// your Lambda function. Higher-numbered versions add fields that support new
    /// features.
    ///
    /// You must use a `LambdaVersion` of `V1_0` with an inbound federation
    /// function.
    lambda_version: InboundFederationLambdaVersionType,

    pub const json_field_names = .{
        .lambda_arn = "LambdaArn",
        .lambda_version = "LambdaVersion",
    };
};
