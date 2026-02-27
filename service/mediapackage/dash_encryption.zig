const SpekeKeyProvider = @import("speke_key_provider.zig").SpekeKeyProvider;

/// A Dynamic Adaptive Streaming over HTTP (DASH) encryption configuration.
pub const DashEncryption = struct {
    /// Time (in seconds) between each encryption key rotation.
    key_rotation_interval_seconds: ?i32,

    speke_key_provider: SpekeKeyProvider,

    pub const json_field_names = .{
        .key_rotation_interval_seconds = "KeyRotationIntervalSeconds",
        .speke_key_provider = "SpekeKeyProvider",
    };
};
