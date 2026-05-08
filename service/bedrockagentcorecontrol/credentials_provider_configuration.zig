const PaymentCredentialProviderConfiguration = @import("payment_credential_provider_configuration.zig").PaymentCredentialProviderConfiguration;

/// The credential provider configuration for a payment connector. Specifies the
/// payment provider type and its associated credential provider.
pub const CredentialsProviderConfiguration = union(enum) {
    /// The credential provider configuration for a Coinbase CDP payment connector.
    coinbase_cdp: ?PaymentCredentialProviderConfiguration,
    /// The credential provider configuration for a Stripe Privy payment connector.
    stripe_privy: ?PaymentCredentialProviderConfiguration,

    pub const json_field_names = .{
        .coinbase_cdp = "coinbaseCDP",
        .stripe_privy = "stripePrivy",
    };
};
