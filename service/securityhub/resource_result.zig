const ResourceFindingsSummary = @import("resource_findings_summary.zig").ResourceFindingsSummary;
const ResourceCategory = @import("resource_category.zig").ResourceCategory;
const ResourceTag = @import("resource_tag.zig").ResourceTag;

/// Provides comprehensive details about an Amazon Web Services resource and its
/// associated security findings.
pub const ResourceResult = struct {
    /// The Amazon Web Services account that owns the resource.
    account_id: []const u8,

    /// An aggregated view of security findings associated with a resource.
    findings_summary: ?[]const ResourceFindingsSummary,

    /// The Amazon Web Services Region where the resource is located.
    region: []const u8,

    /// The grouping where the resource belongs.
    resource_category: ?ResourceCategory,

    /// The configuration details of a resource.
    resource_config: []const u8,

    /// The time when the resource was created.
    resource_creation_time_dt: ?[]const u8,

    /// The timestamp when information about the resource was captured.
    resource_detail_capture_time_dt: []const u8,

    /// The global identifier used to identify a resource.
    resource_guid: ?[]const u8,

    /// The unique identifier for a resource.
    resource_id: []const u8,

    /// The name of the resource.
    resource_name: ?[]const u8,

    /// The key-value pairs associated with a resource.
    resource_tags: ?[]const ResourceTag,

    /// The type of resource.
    resource_type: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .findings_summary = "FindingsSummary",
        .region = "Region",
        .resource_category = "ResourceCategory",
        .resource_config = "ResourceConfig",
        .resource_creation_time_dt = "ResourceCreationTimeDt",
        .resource_detail_capture_time_dt = "ResourceDetailCaptureTimeDt",
        .resource_guid = "ResourceGuid",
        .resource_id = "ResourceId",
        .resource_name = "ResourceName",
        .resource_tags = "ResourceTags",
        .resource_type = "ResourceType",
    };
};
