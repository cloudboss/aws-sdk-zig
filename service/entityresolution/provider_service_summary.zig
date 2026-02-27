const ServiceType = @import("service_type.zig").ServiceType;

/// A list of `ProviderService` objects, each of which contain the fields
/// `providerName`, `providerServiceArn`, `providerServiceName`, and
/// `providerServiceType`.
pub const ProviderServiceSummary = struct {
    /// The name of the provider. This name is typically the company name.
    provider_name: []const u8,

    /// The ARN (Amazon Resource Name) that Entity Resolution generated for the
    /// `providerService`.
    provider_service_arn: []const u8,

    /// The display name of the provider service.
    provider_service_display_name: []const u8,

    /// The name of the product that the provider service provides.
    provider_service_name: []const u8,

    /// The type of provider service.
    provider_service_type: ServiceType,

    pub const json_field_names = .{
        .provider_name = "providerName",
        .provider_service_arn = "providerServiceArn",
        .provider_service_display_name = "providerServiceDisplayName",
        .provider_service_name = "providerServiceName",
        .provider_service_type = "providerServiceType",
    };
};
