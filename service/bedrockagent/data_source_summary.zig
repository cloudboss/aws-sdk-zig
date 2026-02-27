const DataSourceStatus = @import("data_source_status.zig").DataSourceStatus;

/// Contains details about a data source.
pub const DataSourceSummary = struct {
    /// The unique identifier of the data source.
    data_source_id: []const u8,

    /// The description of the data source.
    description: ?[]const u8,

    /// The unique identifier of the knowledge base to which the data source
    /// belongs.
    knowledge_base_id: []const u8,

    /// The name of the data source.
    name: []const u8,

    /// The status of the data source.
    status: DataSourceStatus,

    /// The time at which the data source was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .data_source_id = "dataSourceId",
        .description = "description",
        .knowledge_base_id = "knowledgeBaseId",
        .name = "name",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
