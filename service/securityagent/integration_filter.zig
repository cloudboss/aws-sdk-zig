const Provider = @import("provider.zig").Provider;
const ProviderType = @import("provider_type.zig").ProviderType;

/// A filter for listing integrations. This is a union type where you can filter
/// by provider or provider type.
pub const IntegrationFilter = union(enum) {
    /// Filter integrations by provider.
    provider: ?Provider,
    /// Filter integrations by provider type.
    provider_type: ?ProviderType,

    pub const json_field_names = .{
        .provider = "provider",
        .provider_type = "providerType",
    };
};
