const DiscoveryType = @import("discovery_type.zig").DiscoveryType;
const ResourceFindingsSummary = @import("resource_findings_summary.zig").ResourceFindingsSummary;
const ResourceCategory = @import("resource_category.zig").ResourceCategory;
const ResourceInfo = @import("resource_info.zig").ResourceInfo;
const ResourceSubCategory = @import("resource_sub_category.zig").ResourceSubCategory;
const ResourceTag = @import("resource_tag.zig").ResourceTag;

/// Provides comprehensive details about an Amazon Web Services resource and its
/// associated security findings.
pub const ResourceResult = struct {
    /// The Amazon Web Services account that recorded the resource data in Security
    /// Hub.
    account_id: []const u8,

    /// The name of the Amazon Web Services account that's associated with the
    /// resource.
    account_name: ?[]const u8 = null,

    /// Specifies how the resource was discovered. If the value is `Managed`, the
    /// resource is natively provided by a cloud service provider. If the value is
    /// `SelfHosted`, the resource is hosted on customer-managed infrastructure,
    /// such as a compute instance or container image.
    discovery_type: ?DiscoveryType = null,

    /// An aggregated view of security findings associated with a resource.
    findings_summary: ?[]const ResourceFindingsSummary = null,

    /// The Amazon Web Services Region that recorded the resource data in Security
    /// Hub.
    region: []const u8,

    /// The grouping where the resource belongs.
    resource_category: ?ResourceCategory = null,

    /// The cloud partition where the resource exists. For Amazon Web Services,
    /// valid values include `aws`, `aws-cn`, and `aws-us-gov`. This field isn't
    /// returned for cloud providers that don't use partitions.
    resource_cloud_partition: ?[]const u8 = null,

    /// The configuration details of a resource.
    resource_config: []const u8,

    /// The time when the resource was created.
    resource_creation_time_dt: ?[]const u8 = null,

    /// The timestamp when information about the resource was captured.
    resource_detail_capture_time_dt: []const u8,

    /// The global identifier used to identify a resource.
    resource_guid: ?[]const u8 = null,

    /// The unique identifier for a resource.
    resource_id: []const u8,

    /// Additional resource-type-specific details. For self-hosted AI resources and
    /// their host resources, contains an `AIDetails` structure.
    resource_info: ?ResourceInfo = null,

    /// The name of the resource.
    resource_name: ?[]const u8 = null,

    /// The identifier of the cloud account that owns the resource. For Amazon Web
    /// Services resources, this is the Amazon Web Services account ID. For Azure
    /// resources, this is the Azure subscription ID.
    resource_owner_account_id: ?[]const u8 = null,

    /// The identifier of the cloud organization that owns the resource. For Amazon
    /// Web Services resources, this is the Organizations ID. For Azure resources,
    /// this is the Azure tenant ID.
    resource_owner_org_id: ?[]const u8 = null,

    /// The cloud provider where the resource exists. Valid values are `AWS` and
    /// `Azure`. This field is always included.
    resource_provider: ?[]const u8 = null,

    /// The native cloud region where the resource is located. For Amazon Web
    /// Services, this is an Amazon Web Services Region (for example, `us-east-1`).
    /// For Azure resources, this is the Azure region (for example, `westus2`). This
    /// field is always included.
    resource_region: ?[]const u8 = null,

    /// The AI/ML sub-grouping of the resource. Present only when `ResourceCategory`
    /// is `AI/ML`.
    resource_sub_category: ?ResourceSubCategory = null,

    /// The key-value pairs associated with a resource.
    resource_tags: ?[]const ResourceTag = null,

    /// The type of resource.
    resource_type: []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .account_name = "AccountName",
        .discovery_type = "DiscoveryType",
        .findings_summary = "FindingsSummary",
        .region = "Region",
        .resource_category = "ResourceCategory",
        .resource_cloud_partition = "ResourceCloudPartition",
        .resource_config = "ResourceConfig",
        .resource_creation_time_dt = "ResourceCreationTimeDt",
        .resource_detail_capture_time_dt = "ResourceDetailCaptureTimeDt",
        .resource_guid = "ResourceGuid",
        .resource_id = "ResourceId",
        .resource_info = "ResourceInfo",
        .resource_name = "ResourceName",
        .resource_owner_account_id = "ResourceOwnerAccountId",
        .resource_owner_org_id = "ResourceOwnerOrgId",
        .resource_provider = "ResourceProvider",
        .resource_region = "ResourceRegion",
        .resource_sub_category = "ResourceSubCategory",
        .resource_tags = "ResourceTags",
        .resource_type = "ResourceType",
    };
};
