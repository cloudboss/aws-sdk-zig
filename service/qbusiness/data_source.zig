const DataSourceStatus = @import("data_source_status.zig").DataSourceStatus;

/// A data source in an Amazon Q Business application.
pub const DataSource = struct {
    /// The Unix timestamp when the Amazon Q Business data source was created.
    created_at: ?i64,

    /// The identifier of the Amazon Q Business data source.
    data_source_id: ?[]const u8,

    /// The name of the Amazon Q Business data source.
    display_name: ?[]const u8,

    /// The status of the Amazon Q Business data source.
    status: ?DataSourceStatus,

    /// The type of the Amazon Q Business data source.
    @"type": ?[]const u8,

    /// The Unix timestamp when the Amazon Q Business data source was last updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .data_source_id = "dataSourceId",
        .display_name = "displayName",
        .status = "status",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};
