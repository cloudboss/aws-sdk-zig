/// Specifies an authentication configuration for the private docker registry
/// where your model image is hosted. Specify a value for this property only if
/// you specified `Vpc` as the value for the `RepositoryAccessMode` field of the
/// `ImageConfig` object that you passed to a call to `CreateModel` and the
/// private Docker registry where the model image is hosted requires
/// authentication.
pub const RepositoryAuthConfig = struct {
    /// The Amazon Resource Name (ARN) of an Amazon Web Services Lambda function
    /// that provides credentials to authenticate to the private Docker registry
    /// where your model image is hosted. For information about how to create an
    /// Amazon Web Services Lambda function, see [Create a Lambda function with the
    /// console](https://docs.aws.amazon.com/lambda/latest/dg/getting-started-create-function.html) in the *Amazon Web Services Lambda Developer Guide*.
    repository_credentials_provider_arn: []const u8,

    pub const json_field_names = .{
        .repository_credentials_provider_arn = "RepositoryCredentialsProviderArn",
    };
};
