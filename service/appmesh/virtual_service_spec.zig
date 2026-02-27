const VirtualServiceProvider = @import("virtual_service_provider.zig").VirtualServiceProvider;

/// An object that represents the specification of a virtual service.
pub const VirtualServiceSpec = struct {
    /// The App Mesh object that is acting as the provider for a virtual service.
    /// You
    /// can specify a single virtual node or virtual router.
    provider: ?VirtualServiceProvider,

    pub const json_field_names = .{
        .provider = "provider",
    };
};
