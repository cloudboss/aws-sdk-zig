const MediaLiveTransitEncryptionKeyConfiguration = @import("media_live_transit_encryption_key_configuration.zig").MediaLiveTransitEncryptionKeyConfiguration;
const MediaLiveTransitEncryptionKeyType = @import("media_live_transit_encryption_key_type.zig").MediaLiveTransitEncryptionKeyType;

/// The encryption configuration that defines how content is encrypted during
/// transit between MediaConnect Router and MediaLive. This configuration
/// determines whether encryption keys are automatically managed by the service
/// or manually managed through Secrets Manager.
pub const MediaLiveTransitEncryption = struct {
    /// The configuration details for the MediaLive encryption key.
    encryption_key_configuration: MediaLiveTransitEncryptionKeyConfiguration,

    /// The type of encryption key to use for MediaLive transit encryption.
    encryption_key_type: ?MediaLiveTransitEncryptionKeyType,

    pub const json_field_names = .{
        .encryption_key_configuration = "EncryptionKeyConfiguration",
        .encryption_key_type = "EncryptionKeyType",
    };
};
