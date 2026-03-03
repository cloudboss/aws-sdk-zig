/// Defines a logical resource identifier.
pub const LogicalResourceId = struct {
    /// Name of the Amazon Elastic Kubernetes Service cluster and namespace this
    /// resource belongs to.
    ///
    /// This parameter accepts values in "eks-cluster/namespace" format.
    eks_source_name: ?[]const u8 = null,

    /// Identifier of the resource.
    identifier: []const u8,

    /// The name of the CloudFormation stack this resource belongs to.
    logical_stack_name: ?[]const u8 = null,

    /// The name of the resource group that this resource belongs to.
    resource_group_name: ?[]const u8 = null,

    /// The name of the Terraform S3 state file this resource belongs to.
    terraform_source_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .eks_source_name = "eksSourceName",
        .identifier = "identifier",
        .logical_stack_name = "logicalStackName",
        .resource_group_name = "resourceGroupName",
        .terraform_source_name = "terraformSourceName",
    };
};
