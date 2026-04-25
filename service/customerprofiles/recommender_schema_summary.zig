const aws = @import("aws");

const RecommenderSchemaField = @import("recommender_schema_field.zig").RecommenderSchemaField;
const RecommenderSchemaStatus = @import("recommender_schema_status.zig").RecommenderSchemaStatus;

/// Provides a summary of a recommender schema's configuration and current
/// state.
pub const RecommenderSchemaSummary = struct {
    /// The timestamp when the recommender schema was created.
    created_at: i64,

    /// A map of dataset type to column definitions included in the schema.
    fields: []const aws.map.MapEntry([]const RecommenderSchemaField),

    /// The name of the recommender schema.
    recommender_schema_name: []const u8,

    /// The current operational status of the recommender schema.
    status: RecommenderSchemaStatus,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .fields = "Fields",
        .recommender_schema_name = "RecommenderSchemaName",
        .status = "Status",
    };
};
