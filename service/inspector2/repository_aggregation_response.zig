const Provider = @import("provider.zig").Provider;
const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// A response that contains details on the results of a finding aggregation by
/// repository.
pub const RepositoryAggregationResponse = struct {
    /// The ID of the Amazon Web Services account associated with the findings.
    account_id: ?[]const u8 = null,

    /// The number of container images impacted by the findings.
    affected_images: ?i64 = null,

    /// The cloud account ID for the repository aggregation.
    cloud_account_id: ?[]const u8 = null,

    /// The cloud organization ID for the repository aggregation.
    cloud_org_id: ?[]const u8 = null,

    /// The cloud infrastructure partition associated with this repository
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

    /// The cloud service provider associated with this repository aggregation.
    /// Valid values:
    ///
    /// * `AWS` – Findings from Amazon Web Services resources.
    ///
    /// * `AZURE` – Findings from Microsoft Azure resources.
    cloud_provider: ?Provider = null,

    /// The cloud Region associated with this repository aggregation. The value
    /// format depends on the cloud provider:
    ///
    /// * An Amazon Web Services Region, such as `us-east-1`.
    ///
    /// * An Azure region, such as `eastus`.
    cloud_region: ?[]const u8 = null,

    /// The name of the repository associated with the findings.
    repository: []const u8,

    /// An object that represent the count of matched findings per severity.
    severity_counts: ?SeverityCounts = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .affected_images = "affectedImages",
        .cloud_account_id = "cloudAccountId",
        .cloud_org_id = "cloudOrgId",
        .cloud_partition = "cloudPartition",
        .cloud_provider = "cloudProvider",
        .cloud_region = "cloudRegion",
        .repository = "repository",
        .severity_counts = "severityCounts",
    };
};
