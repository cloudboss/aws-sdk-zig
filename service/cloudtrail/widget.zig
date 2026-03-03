const aws = @import("aws");

/// A widget on a CloudTrail Lake dashboard.
pub const Widget = struct {
    /// The query alias used to identify the query for the widget.
    query_alias: ?[]const u8 = null,

    /// The query parameters for the widget.
    query_parameters: ?[]const []const u8 = null,

    /// The SQL query statement for the widget.
    query_statement: ?[]const u8 = null,

    /// The view properties for the widget. For more information about view
    /// properties, see [
    /// View properties for widgets
    /// ](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/lake-widget-properties.html) in the *CloudTrail User Guide*..
    view_properties: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .query_alias = "QueryAlias",
        .query_parameters = "QueryParameters",
        .query_statement = "QueryStatement",
        .view_properties = "ViewProperties",
    };
};
