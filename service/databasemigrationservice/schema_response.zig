const DatabaseShortInfoResponse = @import("database_short_info_response.zig").DatabaseShortInfoResponse;
const SchemaShortInfoResponse = @import("schema_short_info_response.zig").SchemaShortInfoResponse;
const ServerShortInfoResponse = @import("server_short_info_response.zig").ServerShortInfoResponse;

/// Describes a schema in a Fleet Advisor collector inventory.
pub const SchemaResponse = struct {
    /// The number of lines of code in a schema in a Fleet Advisor collector
    /// inventory.
    code_line_count: ?i64 = null,

    /// The size level of the code in a schema in a Fleet Advisor collector
    /// inventory.
    code_size: ?i64 = null,

    /// The complexity level of the code in a schema in a Fleet Advisor collector
    /// inventory.
    complexity: ?[]const u8 = null,

    /// The database for a schema in a Fleet Advisor collector inventory.
    database_instance: ?DatabaseShortInfoResponse = null,

    original_schema: ?SchemaShortInfoResponse = null,

    /// The ID of a schema in a Fleet Advisor collector inventory.
    schema_id: ?[]const u8 = null,

    /// The name of a schema in a Fleet Advisor collector inventory.
    schema_name: ?[]const u8 = null,

    /// The database server for a schema in a Fleet Advisor collector inventory.
    server: ?ServerShortInfoResponse = null,

    /// The similarity value for a schema in a Fleet Advisor collector inventory. A
    /// higher similarity value
    /// indicates that a schema is likely to be a duplicate.
    similarity: ?f64 = null,

    pub const json_field_names = .{
        .code_line_count = "CodeLineCount",
        .code_size = "CodeSize",
        .complexity = "Complexity",
        .database_instance = "DatabaseInstance",
        .original_schema = "OriginalSchema",
        .schema_id = "SchemaId",
        .schema_name = "SchemaName",
        .server = "Server",
        .similarity = "Similarity",
    };
};
