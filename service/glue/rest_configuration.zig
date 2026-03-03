const aws = @import("aws");

const EntityConfiguration = @import("entity_configuration.zig").EntityConfiguration;
const SourceConfiguration = @import("source_configuration.zig").SourceConfiguration;

/// Configuration that defines HTTP request and response handling, validation
/// endpoints, and entity configurations for REST API interactions.
pub const RestConfiguration = struct {
    /// A map of entity configurations that define how to interact with different
    /// data entities available through the REST API, including their schemas and
    /// access patterns.
    entity_configurations: ?[]const aws.map.MapEntry(EntityConfiguration) = null,

    /// Global configuration settings that apply to all REST API requests for this
    /// connection type, including common request methods, paths, and parameters.
    global_source_configuration: ?SourceConfiguration = null,

    /// Configuration for the endpoint used to validate connection credentials and
    /// test connectivity during connection creation.
    validation_endpoint_configuration: ?SourceConfiguration = null,

    pub const json_field_names = .{
        .entity_configurations = "EntityConfigurations",
        .global_source_configuration = "GlobalSourceConfiguration",
        .validation_endpoint_configuration = "ValidationEndpointConfiguration",
    };
};
