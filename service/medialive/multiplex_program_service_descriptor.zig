/// Transport stream service descriptor configuration for the Multiplex program.
pub const MultiplexProgramServiceDescriptor = struct {
    /// Name of the provider.
    provider_name: []const u8,

    /// Name of the service.
    service_name: []const u8,

    pub const json_field_names = .{
        .provider_name = "ProviderName",
        .service_name = "ServiceName",
    };
};
