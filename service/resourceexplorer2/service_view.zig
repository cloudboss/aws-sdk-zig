const SearchFilter = @import("search_filter.zig").SearchFilter;
const IncludedProperty = @import("included_property.zig").IncludedProperty;

/// Contains the configuration and properties of a Resource Explorer service
/// view.
pub const ServiceView = struct {
    filters: ?SearchFilter = null,

    /// A list of additional resource properties that are included in this view for
    /// search and filtering purposes.
    included_properties: ?[]const IncludedProperty = null,

    /// The scope type of the service view, which determines what resources are
    /// included.
    scope_type: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the service view.
    service_view_arn: []const u8,

    /// The name of the service view.
    service_view_name: ?[]const u8 = null,

    /// The Amazon Web Services service that has streaming access to this view's
    /// data.
    streaming_access_for_service: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .included_properties = "IncludedProperties",
        .scope_type = "ScopeType",
        .service_view_arn = "ServiceViewArn",
        .service_view_name = "ServiceViewName",
        .streaming_access_for_service = "StreamingAccessForService",
    };
};
