const DirectQueryDataSourceType = @import("direct_query_data_source_type.zig").DirectQueryDataSourceType;
const Tag = @import("tag.zig").Tag;

/// The configuration details for a data source that can be directly queried.
pub const DirectQueryDataSource = struct {
    /// The unique, system-generated identifier that represents the data source.
    data_source_arn: ?[]const u8 = null,

    /// A unique, user-defined label to identify the data source within your
    /// OpenSearch
    /// Service environment.
    data_source_name: ?[]const u8 = null,

    /// The supported Amazon Web Services service that is used as the source for
    /// direct
    /// queries in OpenSearch Service.
    data_source_type: ?DirectQueryDataSourceType = null,

    /// A description that provides additional context and details about the data
    /// source.
    description: ?[]const u8 = null,

    /// A list of Amazon Resource Names (ARNs) for the OpenSearch collections that
    /// are
    /// associated with the direct query data source.
    open_search_arns: ?[]const []const u8 = null,

    /// A list of tags attached to a direct query data source.
    tag_list: ?[]const Tag = null,

    pub const json_field_names = .{
        .data_source_arn = "DataSourceArn",
        .data_source_name = "DataSourceName",
        .data_source_type = "DataSourceType",
        .description = "Description",
        .open_search_arns = "OpenSearchArns",
        .tag_list = "TagList",
    };
};
