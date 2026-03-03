/// Provisioning artifact output.
pub const ProvisioningArtifactOutput = struct {
    /// Description of the provisioning artifact output key.
    description: ?[]const u8 = null,

    /// The provisioning artifact output key.
    key: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .key = "Key",
    };
};
