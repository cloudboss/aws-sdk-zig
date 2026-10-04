const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// A response that contains the results of a finding type aggregation.
pub const FindingTypeAggregationResponse = struct {
    /// The ID of the Amazon Web Services account associated with the findings.
    account_id: ?[]const u8 = null,

    /// The cloud account ID for the finding type aggregation.
    cloud_account_id: ?[]const u8 = null,

    /// The cloud organization ID for the finding type aggregation.
    cloud_org_id: ?[]const u8 = null,

    /// The cloud infrastructure partition associated with this finding type
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

    /// The cloud service provider associated with this finding type aggregation.
    /// Valid values:
    ///
    /// * `AWS` – Findings from Amazon Web Services resources.
    ///
    /// * `AZURE` – Findings from Microsoft Azure resources.
    cloud_provider: ?[]const u8 = null,

    /// The cloud Region associated with this finding type aggregation. The value
    /// format depends on the cloud provider:
    ///
    /// * An Amazon Web Services Region, such as `us-east-1`.
    ///
    /// * An Azure region, such as `eastus`.
    cloud_region: ?[]const u8 = null,

    /// The number of findings that have an exploit available.
    exploit_available_count: ?i64 = null,

    /// Details about the number of fixes.
    fix_available_count: ?i64 = null,

    /// The value to sort results by.
    severity_counts: ?SeverityCounts = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .cloud_account_id = "cloudAccountId",
        .cloud_org_id = "cloudOrgId",
        .cloud_partition = "cloudPartition",
        .cloud_provider = "cloudProvider",
        .cloud_region = "cloudRegion",
        .exploit_available_count = "exploitAvailableCount",
        .fix_available_count = "fixAvailableCount",
        .severity_counts = "severityCounts",
    };
};
