const RouterInputTransitEncryptionKeyConfiguration = @import("router_input_transit_encryption_key_configuration.zig").RouterInputTransitEncryptionKeyConfiguration;
const RouterInputTransitEncryptionKeyType = @import("router_input_transit_encryption_key_type.zig").RouterInputTransitEncryptionKeyType;

/// The transit encryption settings for a router input.
pub const RouterInputTransitEncryption = struct {
    /// Contains the configuration details for the encryption key used in transit
    /// encryption, including the key source and associated parameters.
    encryption_key_configuration: RouterInputTransitEncryptionKeyConfiguration,

    /// Specifies the type of encryption key to use for transit encryption.
    encryption_key_type: ?RouterInputTransitEncryptionKeyType,

    pub const json_field_names = .{
        .encryption_key_configuration = "EncryptionKeyConfiguration",
        .encryption_key_type = "EncryptionKeyType",
    };
};
