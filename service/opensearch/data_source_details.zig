const DataSourceType = @import("data_source_type.zig").DataSourceType;
const DataSourceStatus = @import("data_source_status.zig").DataSourceStatus;

/// Details about a direct-query data source.
pub const DataSourceDetails = struct {
    /// The type of data source.
    data_source_type: ?DataSourceType = null,

    /// A description of the data source.
    description: ?[]const u8 = null,

    /// The name of the data source.
    name: ?[]const u8 = null,

    /// The status of the data source.
    status: ?DataSourceStatus = null,

    pub const json_field_names = .{
        .data_source_type = "DataSourceType",
        .description = "Description",
        .name = "Name",
        .status = "Status",
    };
};
