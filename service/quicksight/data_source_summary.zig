const DataSourceType = @import("data_source_type.zig").DataSourceType;

/// A `DataSourceSummary` object that returns a summary of a data source.
pub const DataSourceSummary = struct {
    /// The arn of the datasource.
    arn: ?[]const u8 = null,

    /// The date and time that the data source was created. This value is expressed
    /// in MM-DD-YYYY HH:MM:SS format.
    created_time: ?i64 = null,

    /// The unique ID of the data source.
    data_source_id: ?[]const u8 = null,

    /// The date and time the data source was last updated. This value is expressed
    /// in MM-DD-YYYY HH:MM:SS format.
    last_updated_time: ?i64 = null,

    /// The name of the data source.
    name: ?[]const u8 = null,

    /// The type of the data source.
    @"type": ?DataSourceType = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .data_source_id = "DataSourceId",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .@"type" = "Type",
    };
};
