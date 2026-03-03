const aws = @import("aws");

const ProvisioningArtifactType = @import("provisioning_artifact_type.zig").ProvisioningArtifactType;

/// Information about a provisioning artifact (also known as a version) for a
/// product.
pub const ProvisioningArtifactProperties = struct {
    /// The description of the provisioning artifact, including how it differs from
    /// the previous provisioning artifact.
    description: ?[]const u8 = null,

    /// If set to true, Service Catalog stops validating the specified provisioning
    /// artifact even if it is invalid.
    ///
    /// Service Catalog does not support template validation for the `TERRAFORM_OS`
    /// product type.
    disable_template_validation: bool = false,

    /// Specify the template source with one of the following options, but not both.
    /// Keys accepted: [ `LoadTemplateFromURL`, `ImportFromPhysicalId` ]
    ///
    /// The URL of the CloudFormation template in Amazon S3 or GitHub in JSON
    /// format.
    /// Specify the URL in JSON format as follows:
    ///
    /// `"LoadTemplateFromURL":
    /// "https://s3.amazonaws.com/cf-templates-ozkq9d3hgiq2-us-east-1/..."`
    ///
    /// `ImportFromPhysicalId`: The physical id of the resource that contains the
    /// template. Currently only supports CloudFormation stack arn. Specify the
    /// physical id in JSON
    /// format as follows: `ImportFromPhysicalId:
    /// “arn:aws:cloudformation:[us-east-1]:[accountId]:stack/[StackName]/[resourceId]`
    info: ?[]const aws.map.StringMapEntry = null,

    /// The name of the provisioning artifact (for example, v1 v2beta). No spaces
    /// are allowed.
    name: ?[]const u8 = null,

    /// The type of provisioning artifact.
    ///
    /// * `CLOUD_FORMATION_TEMPLATE` - CloudFormation template
    ///
    /// * `TERRAFORM_OPEN_SOURCE` - Terraform Open Source configuration file
    ///
    /// * `TERRAFORM_CLOUD` - Terraform Cloud configuration file
    ///
    /// * `EXTERNAL` - External configuration file
    @"type": ?ProvisioningArtifactType = null,

    pub const json_field_names = .{
        .description = "Description",
        .disable_template_validation = "DisableTemplateValidation",
        .info = "Info",
        .name = "Name",
        .@"type" = "Type",
    };
};
