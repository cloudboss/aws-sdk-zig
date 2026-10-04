const aws = @import("aws");

const Provider = @import("provider.zig").Provider;
const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// A response that contains the results of a serverless function aggregation.
pub const ServerlessFunctionAggregationResponse = struct {
    /// The account ID associated with the serverless function.
    account_id: ?[]const u8 = null,

    /// The cloud account ID for the serverless function aggregation.
    cloud_account_id: ?[]const u8 = null,

    /// The cloud organization ID for the serverless function aggregation.
    cloud_org_id: ?[]const u8 = null,

    /// The cloud infrastructure partition associated with this serverless function
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

    /// The cloud service provider associated with this serverless function
    /// aggregation. Valid values:
    ///
    /// * `AWS` – Findings from Amazon Web Services resources.
    ///
    /// * `AZURE` – Findings from Microsoft Azure resources.
    cloud_provider: ?Provider = null,

    /// The cloud Region associated with this serverless function aggregation. The
    /// value format depends on the cloud provider:
    ///
    /// * An Amazon Web Services Region, such as `us-east-1`.
    ///
    /// * An Azure region, such as `eastus`.
    cloud_region: ?[]const u8 = null,

    /// The number of active findings with an exploit available for the serverless
    /// function.
    exploit_available_active_findings_count: ?i64 = null,

    /// The number of active findings with a fix available for the serverless
    /// function.
    fix_available_active_findings_count: ?i64 = null,

    /// The name of the serverless function.
    function_name: ?[]const u8 = null,

    /// The date and time the serverless function was last modified.
    last_modified_at: ?i64 = null,

    /// The resource ID for the serverless function.
    resource_id: []const u8,

    /// The runtime of the serverless function.
    runtime: ?[]const u8 = null,

    severity_counts: ?SeverityCounts = null,

    /// The tags attached to the serverless function.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .cloud_account_id = "cloudAccountId",
        .cloud_org_id = "cloudOrgId",
        .cloud_partition = "cloudPartition",
        .cloud_provider = "cloudProvider",
        .cloud_region = "cloudRegion",
        .exploit_available_active_findings_count = "exploitAvailableActiveFindingsCount",
        .fix_available_active_findings_count = "fixAvailableActiveFindingsCount",
        .function_name = "functionName",
        .last_modified_at = "lastModifiedAt",
        .resource_id = "resourceId",
        .runtime = "runtime",
        .severity_counts = "severityCounts",
        .tags = "tags",
    };
};
