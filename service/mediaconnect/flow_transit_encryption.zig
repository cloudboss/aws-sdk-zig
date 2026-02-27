const FlowTransitEncryptionKeyConfiguration = @import("flow_transit_encryption_key_configuration.zig").FlowTransitEncryptionKeyConfiguration;
const FlowTransitEncryptionKeyType = @import("flow_transit_encryption_key_type.zig").FlowTransitEncryptionKeyType;

/// The configuration that defines how content is encrypted during transit
/// between the MediaConnect router and a MediaConnect flow.
pub const FlowTransitEncryption = struct {
    /// The configuration details for the encryption key.
    encryption_key_configuration: FlowTransitEncryptionKeyConfiguration,

    /// The type of encryption key to use for flow transit encryption.
    encryption_key_type: ?FlowTransitEncryptionKeyType,

    pub const json_field_names = .{
        .encryption_key_configuration = "EncryptionKeyConfiguration",
        .encryption_key_type = "EncryptionKeyType",
    };
};
