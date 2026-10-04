const Provider = @import("provider.zig").Provider;
const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// A response that contains the results of a finding aggregation by AMI.
pub const AmiAggregationResponse = struct {
    /// The Amazon Web Services account ID for the AMI.
    account_id: ?[]const u8 = null,

    /// The IDs of Amazon EC2 instances using this AMI.
    affected_instances: ?i64 = null,

    /// The ID of the AMI that findings were aggregated for.
    ami: []const u8,

    /// The cloud account ID for the AMI aggregation.
    cloud_account_id: ?[]const u8 = null,

    /// The cloud organization ID for the AMI aggregation.
    cloud_org_id: ?[]const u8 = null,

    /// The cloud infrastructure partition associated with this AMI aggregation.
    /// Valid values:
    ///
    /// * `aws` – Amazon Web Services commercial Regions.
    ///
    /// * `aws-cn` – Amazon Web Services China Regions.
    ///
    /// * `aws-us-gov` – Amazon Web Services GovCloud (US) Regions.
    ///
    /// * `AzureCloud` – Azure commercial Regions.
    cloud_partition: ?[]const u8 = null,

    /// The cloud service provider associated with this Amazon Machine Image (AMI)
    /// aggregation. Valid values:
    ///
    /// * `AWS` – Findings from Amazon Web Services resources.
    ///
    /// * `AZURE` – Findings from Microsoft Azure resources.
    cloud_provider: ?Provider = null,

    /// The cloud Region associated with this AMI aggregation. The value format
    /// depends on the cloud provider:
    ///
    /// * An Amazon Web Services Region, such as `us-east-1`.
    ///
    /// * An Azure region, such as `eastus`.
    cloud_region: ?[]const u8 = null,

    /// An object that contains the count of matched findings per severity.
    severity_counts: ?SeverityCounts = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .affected_instances = "affectedInstances",
        .ami = "ami",
        .cloud_account_id = "cloudAccountId",
        .cloud_org_id = "cloudOrgId",
        .cloud_partition = "cloudPartition",
        .cloud_provider = "cloudProvider",
        .cloud_region = "cloudRegion",
        .severity_counts = "severityCounts",
    };
};
