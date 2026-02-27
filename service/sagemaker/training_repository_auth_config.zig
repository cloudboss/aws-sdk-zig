/// An object containing authentication information for a private Docker
/// registry.
pub const TrainingRepositoryAuthConfig = struct {
    /// The Amazon Resource Name (ARN) of an Amazon Web Services Lambda function
    /// used to give SageMaker access credentials to your private Docker registry.
    training_repository_credentials_provider_arn: []const u8,

    pub const json_field_names = .{
        .training_repository_credentials_provider_arn = "TrainingRepositoryCredentialsProviderArn",
    };
};
