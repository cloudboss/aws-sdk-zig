const IntermediateSourceConfiguration = @import("intermediate_source_configuration.zig").IntermediateSourceConfiguration;

/// An object containing the `providerServiceARN`,
/// `intermediateSourceConfiguration`, and `providerConfiguration`.
pub const ProviderProperties = struct {
    /// The Amazon S3 location that temporarily stores your data while it processes.
    /// Your information won't be saved permanently.
    intermediate_source_configuration: ?IntermediateSourceConfiguration = null,

    /// The required configuration fields to use with the provider service.
    provider_configuration: ?[]const u8 = null,

    /// The ARN of the provider service.
    provider_service_arn: []const u8,

    pub const json_field_names = .{
        .intermediate_source_configuration = "intermediateSourceConfiguration",
        .provider_configuration = "providerConfiguration",
        .provider_service_arn = "providerServiceArn",
    };
};
