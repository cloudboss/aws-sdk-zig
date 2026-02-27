const SchemaVersionType = @import("schema_version_type.zig").SchemaVersionType;
const SchemaVersionVisibility = @import("schema_version_visibility.zig").SchemaVersionVisibility;

pub const ListSchemaVersionsRequest = struct {
    /// The maximum number of results to return at one time.
    max_results: ?i32,

    /// Filter on the name of the schema version.
    namespace: ?[]const u8,

    /// A token that can be used to retrieve the next set of results.
    next_token: ?[]const u8,

    /// Filter on the id of the schema version.
    schema_id: ?[]const u8,

    /// The schema version. If this is left blank, it defaults to the latest
    /// version.
    semantic_version: ?[]const u8,

    /// Filter on the type of schema version.
    type: SchemaVersionType,

    /// The visibility of the schema version.
    visibility: ?SchemaVersionVisibility,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .namespace = "Namespace",
        .next_token = "NextToken",
        .schema_id = "SchemaId",
        .semantic_version = "SemanticVersion",
        .type = "Type",
        .visibility = "Visibility",
    };
};
