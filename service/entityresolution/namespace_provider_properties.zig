/// An object containing `providerConfiguration` and `providerServiceArn`.
pub const NamespaceProviderProperties = struct {
    /// An object which defines any additional configurations required by the
    /// provider service.
    provider_configuration: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the provider service.
    provider_service_arn: []const u8,

    pub const json_field_names = .{
        .provider_configuration = "providerConfiguration",
        .provider_service_arn = "providerServiceArn",
    };
};
