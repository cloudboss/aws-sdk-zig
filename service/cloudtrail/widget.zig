const aws = @import("aws");

/// A widget on a CloudTrail Lake dashboard.
pub const Widget = struct {
    /// The query alias used to identify the query for the widget.
    query_alias: ?[]const u8,

    /// The query parameters for the widget.
    query_parameters: ?[]const []const u8,

    /// The SQL query statement for the widget.
    query_statement: ?[]const u8,

    /// The view properties for the widget. For more information about view
    /// properties, see [
    /// View properties for widgets
    /// ](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/lake-widget-properties.html) in the *CloudTrail User Guide*..
    view_properties: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .query_alias = "QueryAlias",
        .query_parameters = "QueryParameters",
        .query_statement = "QueryStatement",
        .view_properties = "ViewProperties",
    };
};
