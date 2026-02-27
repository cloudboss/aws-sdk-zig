const SearchFilter = @import("search_filter.zig").SearchFilter;
const IncludedProperty = @import("included_property.zig").IncludedProperty;

/// A view is a structure that defines a set of filters that provide a view into
/// the information in the Amazon Web Services Resource Explorer index. The
/// filters specify which information from the index is visible to the users of
/// the view. For example, you can specify filters that include only resources
/// that are tagged with the key "ENV" and the value "DEVELOPMENT" in the
/// results returned by this view. You could also create a second view that
/// includes only resources that are tagged with "ENV" and "PRODUCTION".
pub const View = struct {
    /// An array of SearchFilter objects that specify which resources can be
    /// included in the results of queries made using this view.
    filters: ?SearchFilter,

    /// A structure that contains additional information about the view.
    included_properties: ?[]const IncludedProperty,

    /// The date and time when this view was last modified.
    last_updated_at: ?i64,

    /// The Amazon Web Services account that owns this view.
    owner: ?[]const u8,

    /// An [Amazon resource name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of an Amazon Web Services account, an organization, or an organizational unit (OU) that specifies whether this view includes resources from only the specified Amazon Web Services account, all accounts in the specified organization, or all accounts in the specified OU.
    ///
    /// If not specified, the value defaults to the Amazon Web Services account used
    /// to call this operation.
    scope: ?[]const u8,

    /// The [Amazon resource name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the view.
    view_arn: ?[]const u8,

    /// The name of the view.
    view_name: ?[]const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .included_properties = "IncludedProperties",
        .last_updated_at = "LastUpdatedAt",
        .owner = "Owner",
        .scope = "Scope",
        .view_arn = "ViewArn",
        .view_name = "ViewName",
    };
};
