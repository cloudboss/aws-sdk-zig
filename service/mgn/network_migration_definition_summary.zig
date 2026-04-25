const aws = @import("aws");

const SourceEnvironment = @import("source_environment.zig").SourceEnvironment;

/// A summary of a network migration definition.
pub const NetworkMigrationDefinitionSummary = struct {
    /// The Amazon Resource Name (ARN) of the network migration definition.
    arn: ?[]const u8 = null,

    /// The name of the network migration definition.
    name: ?[]const u8 = null,

    /// The unique identifier of the network migration definition.
    network_migration_definition_id: ?[]const u8 = null,

    /// Scope tags for the network migration definition.
    scope_tags: ?[]const aws.map.StringMapEntry = null,

    /// The source environment configuration.
    source_environment: ?SourceEnvironment = null,

    /// Tags assigned to the network migration definition.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
        .network_migration_definition_id = "networkMigrationDefinitionID",
        .scope_tags = "scopeTags",
        .source_environment = "sourceEnvironment",
        .tags = "tags",
    };
};
