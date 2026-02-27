const ResourceType = @import("resource_type.zig").ResourceType;

/// The criteria for an analysis rule for an internal access analyzer.
pub const InternalAccessAnalysisRuleCriteria = struct {
    /// A list of Amazon Web Services account IDs to apply to the internal access
    /// analysis rule criteria. Account IDs can only be applied to the analysis rule
    /// criteria for organization-level analyzers.
    account_ids: ?[]const []const u8,

    /// A list of resource ARNs to apply to the internal access analysis rule
    /// criteria. The analyzer will only generate findings for resources that match
    /// these ARNs.
    resource_arns: ?[]const []const u8,

    /// A list of resource types to apply to the internal access analysis rule
    /// criteria. The analyzer will only generate findings for resources of these
    /// types. These resource types are currently supported for internal access
    /// analyzers:
    ///
    /// * `AWS::S3::Bucket`
    /// * `AWS::RDS::DBSnapshot`
    /// * `AWS::RDS::DBClusterSnapshot`
    /// * `AWS::S3Express::DirectoryBucket`
    /// * `AWS::DynamoDB::Table`
    /// * `AWS::DynamoDB::Stream`
    resource_types: ?[]const ResourceType,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .resource_arns = "resourceArns",
        .resource_types = "resourceTypes",
    };
};
