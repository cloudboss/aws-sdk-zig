const SearchFilter = @import("search_filter.zig").SearchFilter;
const IncludedProperty = @import("included_property.zig").IncludedProperty;

/// An Amazon Web Services-managed view is how other Amazon Web Services
/// services can access resource information indexed by Resource Explorer for
/// your Amazon Web Services account or organization with your consent. For more
/// information, see [Managed
/// views](https://docs.aws.amazon.com/resource-explorer/latest/userguide/aws-managed-views.html).
pub const ManagedView = struct {
    filters: ?SearchFilter,

    /// A structure that contains additional information about the managed view.
    included_properties: ?[]const IncludedProperty,

    /// The date and time when this managed view was last modified.
    last_updated_at: ?i64,

    /// The [Amazon resource name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the managed view.
    managed_view_arn: ?[]const u8,

    /// The name of the managed view.
    managed_view_name: ?[]const u8,

    /// The Amazon Web Services account that owns this managed view.
    owner: ?[]const u8,

    /// The resource policy that defines access to the managed view. To learn more
    /// about this policy, review [Managed
    /// views](https://docs.aws.amazon.com/resource-explorer/latest/userguide/aws-managed-views.html).
    resource_policy: ?[]const u8,

    /// An [Amazon resource name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of an Amazon Web Services account or organization that specifies whether this managed view includes resources from only the specified Amazon Web Services account or all accounts in the specified organization.
    scope: ?[]const u8,

    /// The service principal of the Amazon Web Services service that created and
    /// manages the managed view.
    trusted_service: ?[]const u8,

    /// The version of the managed view.
    version: ?[]const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .included_properties = "IncludedProperties",
        .last_updated_at = "LastUpdatedAt",
        .managed_view_arn = "ManagedViewArn",
        .managed_view_name = "ManagedViewName",
        .owner = "Owner",
        .resource_policy = "ResourcePolicy",
        .scope = "Scope",
        .trusted_service = "TrustedService",
        .version = "Version",
    };
};
