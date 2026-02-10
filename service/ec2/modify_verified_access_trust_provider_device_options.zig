/// Modifies the configuration of the specified device-based Amazon Web Services
/// Verified Access trust provider.
pub const ModifyVerifiedAccessTrustProviderDeviceOptions = struct {
    /// The URL Amazon Web Services Verified Access will use to verify the
    /// authenticity of the device tokens.
    public_signing_key_url: ?[]const u8,
};
