/// Information about each resource type associated with the
/// `groupedByResource` statistics.
pub const ResourceStatistics = struct {
    /// The ID of the Amazon Web Services account.
    account_id: ?[]const u8 = null,

    /// The timestamp at which the statistics for this resource was last generated.
    last_generated_at: ?i64 = null,

    /// ID associated with each resource. The following list provides the mapping of
    /// the resource type
    /// and resource ID.
    ///
    /// **Mapping of resource and resource ID**
    ///
    /// * AccessKey - `resource.accessKeyDetails.accessKeyId`
    ///
    /// * Container - `resource.containerDetails.id`
    ///
    /// * ECSCluster - `resource.ecsClusterDetails.name`
    ///
    /// * EKSCluster - `resource.eksClusterDetails.name`
    ///
    /// * Instance - `resource.instanceDetails.instanceId`
    ///
    /// * KubernetesCluster -
    ///   `resource.kubernetesDetails.kubernetesWorkloadDetails.name`
    ///
    /// * Lambda - `resource.lambdaDetails.functionName`
    ///
    /// * RDSDBInstance - `resource.rdsDbInstanceDetails.dbInstanceIdentifier`
    ///
    /// * S3Bucket - `resource.s3BucketDetails.name`
    ///
    /// * S3Object - `resource.s3BucketDetails.name`
    resource_id: ?[]const u8 = null,

    /// The type of resource.
    resource_type: ?[]const u8 = null,

    /// The total number of findings associated with this resource.
    total_findings: ?i32 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .last_generated_at = "LastGeneratedAt",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
        .total_findings = "TotalFindings",
    };
};
