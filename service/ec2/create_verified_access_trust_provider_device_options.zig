/// Describes the options when creating an Amazon Web Services Verified Access
/// trust provider using the
/// `device` type.
pub const CreateVerifiedAccessTrustProviderDeviceOptions = struct {
    /// The URL Amazon Web Services Verified Access will use to verify the
    /// authenticity of the device tokens.
    public_signing_key_url: ?[]const u8,

    /// The ID of the tenant application with the device-identity provider.
    tenant_id: ?[]const u8,
};
