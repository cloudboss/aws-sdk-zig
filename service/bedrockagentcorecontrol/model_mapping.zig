const ProviderPrefix = @import("provider_prefix.zig").ProviderPrefix;

/// The configuration that translates model IDs between client-facing names and
/// provider model IDs.
pub const ModelMapping = struct {
    /// The provider prefix configuration used for model ID translation.
    provider_prefix: ?ProviderPrefix = null,

    pub const json_field_names = .{
        .provider_prefix = "providerPrefix",
    };
};
