const ProtectionGroupAggregation = @import("protection_group_aggregation.zig").ProtectionGroupAggregation;
const ProtectionGroupPattern = @import("protection_group_pattern.zig").ProtectionGroupPattern;
const ProtectedResourceType = @import("protected_resource_type.zig").ProtectedResourceType;

/// Narrows the set of protection groups that the call retrieves. You can
/// retrieve a single protection group by its name and you can retrieve all
/// protection groups that are configured with a specific pattern, aggregation,
/// or resource type. You can provide up to one criteria per filter type. Shield
/// Advanced returns the protection groups that exactly match all of the search
/// criteria that you provide.
pub const InclusionProtectionGroupFilters = struct {
    /// The aggregation setting of the protection groups that you want to retrieve.
    aggregations: ?[]const ProtectionGroupAggregation,

    /// The pattern specification of the protection groups that you want to
    /// retrieve.
    patterns: ?[]const ProtectionGroupPattern,

    /// The ID of the protection group that you want to retrieve.
    protection_group_ids: ?[]const []const u8,

    /// The resource type configuration of the protection groups that you want to
    /// retrieve. In the protection group configuration, you specify the resource
    /// type when you set the group's `Pattern` to `BY_RESOURCE_TYPE`.
    resource_types: ?[]const ProtectedResourceType,

    pub const json_field_names = .{
        .aggregations = "Aggregations",
        .patterns = "Patterns",
        .protection_group_ids = "ProtectionGroupIds",
        .resource_types = "ResourceTypes",
    };
};
