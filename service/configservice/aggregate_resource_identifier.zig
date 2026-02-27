const ResourceType = @import("resource_type.zig").ResourceType;

/// The details that identify a resource that is collected by Config aggregator,
/// including the resource type, ID, (if available) the custom resource name,
/// the source account, and source region.
pub const AggregateResourceIdentifier = struct {
    /// The ID of the Amazon Web Services resource.
    resource_id: []const u8,

    /// The name of the Amazon Web Services resource.
    resource_name: ?[]const u8,

    /// The type of the Amazon Web Services resource.
    resource_type: ResourceType,

    /// The 12-digit account ID of the source account.
    source_account_id: []const u8,

    /// The source region where data is aggregated.
    source_region: []const u8,

    pub const json_field_names = .{
        .resource_id = "ResourceId",
        .resource_name = "ResourceName",
        .resource_type = "ResourceType",
        .source_account_id = "SourceAccountId",
        .source_region = "SourceRegion",
    };
};
