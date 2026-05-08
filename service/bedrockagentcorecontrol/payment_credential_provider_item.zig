const PaymentCredentialProviderVendorType = @import("payment_credential_provider_vendor_type.zig").PaymentCredentialProviderVendorType;

/// Contains summary information about a payment credential provider.
pub const PaymentCredentialProviderItem = struct {
    /// The timestamp when the payment credential provider was created.
    created_time: i64,

    /// The Amazon Resource Name (ARN) of the payment credential provider.
    credential_provider_arn: []const u8,

    credential_provider_vendor: PaymentCredentialProviderVendorType,

    /// The timestamp when the payment credential provider was last updated.
    last_updated_time: i64,

    /// The name of the payment credential provider.
    name: []const u8,

    pub const json_field_names = .{
        .created_time = "createdTime",
        .credential_provider_arn = "credentialProviderArn",
        .credential_provider_vendor = "credentialProviderVendor",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
    };
};
