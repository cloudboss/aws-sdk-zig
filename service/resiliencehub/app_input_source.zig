const EksSourceClusterNamespace = @import("eks_source_cluster_namespace.zig").EksSourceClusterNamespace;
const ResourceMappingType = @import("resource_mapping_type.zig").ResourceMappingType;
const TerraformSource = @import("terraform_source.zig").TerraformSource;

/// The list of Resilience Hub application input sources.
pub const AppInputSource = struct {
    /// The namespace on your Amazon Elastic Kubernetes Service cluster.
    eks_source_cluster_namespace: ?EksSourceClusterNamespace,

    /// The resource type of the input source.
    import_type: ResourceMappingType,

    /// The number of resources.
    resource_count: i32 = 0,

    /// The Amazon Resource Name (ARN) of the input source. For more information
    /// about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    source_arn: ?[]const u8,

    /// The name of the input source.
    source_name: ?[]const u8,

    /// The name of the Terraform s3 state ﬁle.
    terraform_source: ?TerraformSource,

    pub const json_field_names = .{
        .eks_source_cluster_namespace = "eksSourceClusterNamespace",
        .import_type = "importType",
        .resource_count = "resourceCount",
        .source_arn = "sourceArn",
        .source_name = "sourceName",
        .terraform_source = "terraformSource",
    };
};
