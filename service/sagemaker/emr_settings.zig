/// The configuration parameters that specify the IAM roles assumed by the
/// execution role of SageMaker (assumable roles) and the cluster instances or
/// job execution environments (execution roles or runtime roles) to manage and
/// access resources required for running Amazon EMR clusters or Amazon EMR
/// Serverless applications.
pub const EmrSettings = struct {
    /// An array of Amazon Resource Names (ARNs) of the IAM roles that the execution
    /// role of SageMaker can assume for performing operations or tasks related to
    /// Amazon EMR clusters or Amazon EMR Serverless applications. These roles
    /// define the permissions and access policies required when performing Amazon
    /// EMR-related operations, such as listing, connecting to, or terminating
    /// Amazon EMR clusters or Amazon EMR Serverless applications. They are
    /// typically used in cross-account access scenarios, where the Amazon EMR
    /// resources (clusters or serverless applications) are located in a different
    /// Amazon Web Services account than the SageMaker domain.
    assumable_role_arns: ?[]const []const u8 = null,

    /// An array of Amazon Resource Names (ARNs) of the IAM roles used by the Amazon
    /// EMR cluster instances or job execution environments to access other Amazon
    /// Web Services services and resources needed during the runtime of your Amazon
    /// EMR or Amazon EMR Serverless workloads, such as Amazon S3 for data access,
    /// Amazon CloudWatch for logging, or other Amazon Web Services services based
    /// on the particular workload requirements.
    execution_role_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .assumable_role_arns = "AssumableRoleArns",
        .execution_role_arns = "ExecutionRoleArns",
    };
};
