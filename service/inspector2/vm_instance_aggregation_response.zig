const aws = @import("aws");

const Provider = @import("provider.zig").Provider;
const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// A response that contains the results of a VM instance aggregation.
pub const VmInstanceAggregationResponse = struct {
    /// The account ID associated with the VM instance.
    account_id: ?[]const u8 = null,

    /// The cloud account ID for the VM instance aggregation.
    cloud_account_id: ?[]const u8 = null,

    /// The cloud organization ID for the VM instance aggregation.
    cloud_org_id: ?[]const u8 = null,

    /// The cloud infrastructure partition associated with this VM instance
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

    /// The cloud service provider associated with this VM instance aggregation.
    /// Valid values:
    ///
    /// * `AWS` – Findings from Amazon Web Services resources.
    ///
    /// * `AZURE` – Findings from Microsoft Azure resources.
    cloud_provider: ?Provider = null,

    /// The cloud Region associated with this VM instance aggregation. The value
    /// format depends on the cloud provider:
    ///
    /// * An Amazon Web Services Region, such as `us-east-1`.
    ///
    /// * An Azure region, such as `eastus`.
    cloud_region: ?[]const u8 = null,

    /// The number of active findings with an exploit available for the VM instance.
    exploit_available_active_findings_count: ?i64 = null,

    /// The number of active findings with a fix available for the VM instance.
    fix_available_active_findings_count: ?i64 = null,

    /// The number of network findings for the VM instance. This field applies only
    /// to Amazon Web Services resources.
    network_findings: ?i64 = null,

    /// The operating system of the VM instance.
    operating_system: ?[]const u8 = null,

    /// The resource ID for the VM instance.
    resource_id: []const u8,

    severity_counts: ?SeverityCounts = null,

    /// The tags attached to the VM instance.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The VM image reference for the VM instance.
    vm_image_reference: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .cloud_account_id = "cloudAccountId",
        .cloud_org_id = "cloudOrgId",
        .cloud_partition = "cloudPartition",
        .cloud_provider = "cloudProvider",
        .cloud_region = "cloudRegion",
        .exploit_available_active_findings_count = "exploitAvailableActiveFindingsCount",
        .fix_available_active_findings_count = "fixAvailableActiveFindingsCount",
        .network_findings = "networkFindings",
        .operating_system = "operatingSystem",
        .resource_id = "resourceId",
        .severity_counts = "severityCounts",
        .tags = "tags",
        .vm_image_reference = "vmImageReference",
    };
};
