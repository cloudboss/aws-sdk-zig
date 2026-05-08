/// Configuration for a payment credential provider that stores authentication
/// credentials for a payment provider.
pub const PaymentCredentialProviderConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the credential provider that stores the
    /// authentication credentials for the payment provider.
    credential_provider_arn: []const u8,

    pub const json_field_names = .{
        .credential_provider_arn = "credentialProviderArn",
    };
};
