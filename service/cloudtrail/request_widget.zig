const aws = @import("aws");

/// Contains information about a widget on a CloudTrail Lake dashboard.
pub const RequestWidget = struct {
    /// The optional query parameters. The following query parameters are valid:
    /// `$StartTime$`, `$EndTime$`, and `$Period$`.
    query_parameters: ?[]const []const u8 = null,

    /// The query statement for the widget. For custom dashboard widgets, you can
    /// query across multiple event data stores as long as all event data stores
    /// exist in your account.
    ///
    /// When a query uses `?` with `eventTime`, `?` must be surrounded by single
    /// quotes as follows: `'?'`.
    query_statement: []const u8,

    /// The view properties for the widget. For more information about view
    /// properties, see [
    /// View properties for widgets
    /// ](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/lake-widget-properties.html) in the *CloudTrail User Guide*.
    view_properties: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .query_parameters = "QueryParameters",
        .query_statement = "QueryStatement",
        .view_properties = "ViewProperties",
    };
};
