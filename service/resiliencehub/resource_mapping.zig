const ResourceMappingType = @import("resource_mapping_type.zig").ResourceMappingType;
const PhysicalResourceId = @import("physical_resource_id.zig").PhysicalResourceId;

/// Defines a resource mapping.
pub const ResourceMapping = struct {
    /// Name of the application this resource is mapped to when the `mappingType` is
    /// `AppRegistryApp`.
    app_registry_app_name: ?[]const u8,

    /// Name of the Amazon Elastic Kubernetes Service cluster and namespace that
    /// this resource is mapped to when the `mappingType` is
    /// `EKS`.
    ///
    /// This parameter accepts values in "eks-cluster/namespace" format.
    eks_source_name: ?[]const u8,

    /// Name of the CloudFormation stack this resource is mapped to when the
    /// `mappingType` is `CfnStack`.
    logical_stack_name: ?[]const u8,

    /// Specifies the type of resource mapping.
    mapping_type: ResourceMappingType,

    /// Identifier of the physical resource.
    physical_resource_id: PhysicalResourceId,

    /// Name of the Resource Groups that this resource is mapped to when the
    /// `mappingType` is `ResourceGroup`.
    resource_group_name: ?[]const u8,

    /// Name of the resource that this resource is mapped to when the `mappingType`
    /// is `Resource`.
    resource_name: ?[]const u8,

    /// Name of the Terraform source that this resource is mapped to when the
    /// `mappingType` is `Terraform`.
    terraform_source_name: ?[]const u8,

    pub const json_field_names = .{
        .app_registry_app_name = "appRegistryAppName",
        .eks_source_name = "eksSourceName",
        .logical_stack_name = "logicalStackName",
        .mapping_type = "mappingType",
        .physical_resource_id = "physicalResourceId",
        .resource_group_name = "resourceGroupName",
        .resource_name = "resourceName",
        .terraform_source_name = "terraformSourceName",
    };
};
