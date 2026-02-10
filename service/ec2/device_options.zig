/// Describes the options for an Amazon Web Services Verified Access
/// device-identity based trust provider.
pub const DeviceOptions = struct {
    /// The URL Amazon Web Services Verified Access will use to verify the
    /// authenticity of the device tokens.
    public_signing_key_url: ?[]const u8,

    /// The ID of the tenant application with the device-identity provider.
    tenant_id: ?[]const u8,
};
