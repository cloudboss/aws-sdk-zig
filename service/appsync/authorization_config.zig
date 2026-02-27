const AuthorizationType = @import("authorization_type.zig").AuthorizationType;
const AwsIamConfig = @import("aws_iam_config.zig").AwsIamConfig;

/// The authorization configuration in case the HTTP endpoint requires
/// authorization.
pub const AuthorizationConfig = struct {
    /// The authorization type that the HTTP endpoint requires.
    ///
    /// * **AWS_IAM**: The authorization type is Signature
    /// Version 4 (SigV4).
    authorization_type: AuthorizationType,

    /// The Identity and Access Management (IAM) settings.
    aws_iam_config: ?AwsIamConfig,

    pub const json_field_names = .{
        .authorization_type = "authorizationType",
        .aws_iam_config = "awsIamConfig",
    };
};
