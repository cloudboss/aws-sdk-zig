const Provider = @import("provider.zig").Provider;
const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// A response that contains the results of a container image aggregation.
pub const ContainerImageAggregationResponse = struct {
    /// The account ID associated with the container image.
    account_id: ?[]const u8 = null,

    /// The architecture of the container image.
    architecture: ?[]const u8 = null,

    /// The cloud account ID for the container image aggregation.
    cloud_account_id: ?[]const u8 = null,

    /// The cloud organization ID for the container image aggregation.
    cloud_org_id: ?[]const u8 = null,

    /// The cloud infrastructure partition associated with this container image
    /// aggregation. Valid values:
    ///
    /// * `aws` – Amazon Web Services commercial Regions.
    ///
    /// * `aws-cn` – Amazon Web Services China Regions.
    ///
    /// * `aws-us-gov` – Amazon Web Services GovCloud (US) Regions.
    ///
    /// * `AzureCloud` – Azure commercial Regions.
    cloud_partition: ?[]const u8 = null,

    /// The cloud service provider associated with this container image aggregation.
    /// Valid values:
    ///
    /// * `AWS` – Findings from Amazon Web Services resources.
    ///
    /// * `AZURE` – Findings from Microsoft Azure resources.
    cloud_provider: ?Provider = null,

    /// The cloud Region associated with this container image aggregation. The value
    /// format depends on the cloud provider:
    ///
    /// * An Amazon Web Services Region, such as `us-east-1`.
    ///
    /// * An Azure region, such as `eastus`.
    cloud_region: ?[]const u8 = null,

    /// The number of active findings with an exploit available for the container
    /// image.
    exploit_available_active_findings_count: ?i64 = null,

    /// The number of active findings with a fix available for the container image.
    fix_available_active_findings_count: ?i64 = null,

    /// The image digest for the container image.
    image_digest: ?[]const u8 = null,

    /// The image tags attached to the container image.
    image_tags: ?[]const []const u8 = null,

    /// The number of times the container image is in use.
    in_use_count: ?i64 = null,

    /// The last time the container image was in use.
    last_in_use_at: ?i64 = null,

    /// The registry for the container image.
    registry: ?[]const u8 = null,

    /// The repository for the container image.
    repository: ?[]const u8 = null,

    /// The resource ID for the container image.
    resource_id: []const u8,

    severity_counts: ?SeverityCounts = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .architecture = "architecture",
        .cloud_account_id = "cloudAccountId",
        .cloud_org_id = "cloudOrgId",
        .cloud_partition = "cloudPartition",
        .cloud_provider = "cloudProvider",
        .cloud_region = "cloudRegion",
        .exploit_available_active_findings_count = "exploitAvailableActiveFindingsCount",
        .fix_available_active_findings_count = "fixAvailableActiveFindingsCount",
        .image_digest = "imageDigest",
        .image_tags = "imageTags",
        .in_use_count = "inUseCount",
        .last_in_use_at = "lastInUseAt",
        .registry = "registry",
        .repository = "repository",
        .resource_id = "resourceId",
        .severity_counts = "severityCounts",
    };
};
