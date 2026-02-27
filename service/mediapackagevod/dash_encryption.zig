const SpekeKeyProvider = @import("speke_key_provider.zig").SpekeKeyProvider;

/// A Dynamic Adaptive Streaming over HTTP (DASH) encryption configuration.
pub const DashEncryption = struct {
    speke_key_provider: SpekeKeyProvider,

    pub const json_field_names = .{
        .speke_key_provider = "SpekeKeyProvider",
    };
};
