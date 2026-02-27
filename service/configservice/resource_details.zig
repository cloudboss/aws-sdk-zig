const ResourceConfigurationSchemaType = @import("resource_configuration_schema_type.zig").ResourceConfigurationSchemaType;

/// Returns information about the resource being evaluated.
pub const ResourceDetails = struct {
    /// The resource definition to be evaluated as per the resource configuration
    /// schema type.
    resource_configuration: []const u8,

    /// The schema type of the resource configuration.
    ///
    /// You can find the
    /// [Resource type
    /// schema](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/resource-type-schema.html), or `CFN_RESOURCE_SCHEMA`, in "*Amazon Web Services public extensions*" within the CloudFormation registry or with the following CLI commmand:
    /// `aws cloudformation describe-type --type-name "AWS::S3::Bucket" --type
    /// RESOURCE`.
    ///
    /// For more information, see [Managing extensions through the CloudFormation
    /// registry](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/registry.html#registry-view)
    /// and [Amazon Web Services resource and property types
    /// reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html) in the CloudFormation User Guide.
    resource_configuration_schema_type: ?ResourceConfigurationSchemaType,

    /// A unique resource ID for an evaluation.
    resource_id: []const u8,

    /// The type of resource being evaluated.
    resource_type: []const u8,

    pub const json_field_names = .{
        .resource_configuration = "ResourceConfiguration",
        .resource_configuration_schema_type = "ResourceConfigurationSchemaType",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};
