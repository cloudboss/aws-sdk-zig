const aws = @import("aws");

const FieldDefinition = @import("field_definition.zig").FieldDefinition;
const SourceConfiguration = @import("source_configuration.zig").SourceConfiguration;

/// Configuration that defines how to interact with a specific data entity
/// through the REST API, including its access patterns and schema definition.
pub const EntityConfiguration = struct {
    /// The schema definition for this entity, including field names, types, and
    /// other metadata that describes the structure of the data.
    schema: ?[]const aws.map.MapEntry(FieldDefinition),

    /// The source configuration that defines how to make requests to access this
    /// entity's data through the REST API.
    source_configuration: ?SourceConfiguration,

    pub const json_field_names = .{
        .schema = "Schema",
        .source_configuration = "SourceConfiguration",
    };
};
