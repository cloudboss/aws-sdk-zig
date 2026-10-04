const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// A response that contains the results of a finding aggregation by image
/// layer.
pub const ImageLayerAggregationResponse = struct {
    /// The ID of the Amazon Web Services account that owns the container image
    /// hosting the layer
    /// image.
    account_id: []const u8,

    /// The cloud account ID for the image layer aggregation.
    cloud_account_id: ?[]const u8 = null,

    /// The cloud organization ID for the image layer aggregation.
    cloud_org_id: ?[]const u8 = null,

    /// The cloud infrastructure partition associated with this image layer
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

    /// The cloud service provider associated with this image layer aggregation.
    /// Valid values:
    ///
    /// * `AWS` – Findings from Amazon Web Services resources.
    ///
    /// * `AZURE` – Findings from Microsoft Azure resources.
    cloud_provider: ?[]const u8 = null,

    /// The cloud Region associated with this image layer aggregation. The value
    /// format depends on the cloud provider:
    ///
    /// * An Amazon Web Services Region, such as `us-east-1`.
    ///
    /// * An Azure region, such as `eastus`.
    cloud_region: ?[]const u8 = null,

    /// The layer hash.
    layer_hash: []const u8,

    /// The repository the layer resides in.
    repository: []const u8,

    /// The resource ID of the container image layer.
    resource_id: []const u8,

    /// An object that represents the count of matched findings per severity.
    severity_counts: ?SeverityCounts = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .cloud_account_id = "cloudAccountId",
        .cloud_org_id = "cloudOrgId",
        .cloud_partition = "cloudPartition",
        .cloud_provider = "cloudProvider",
        .cloud_region = "cloudRegion",
        .layer_hash = "layerHash",
        .repository = "repository",
        .resource_id = "resourceId",
        .severity_counts = "severityCounts",
    };
};
