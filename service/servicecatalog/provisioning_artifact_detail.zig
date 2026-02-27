const ProvisioningArtifactGuidance = @import("provisioning_artifact_guidance.zig").ProvisioningArtifactGuidance;
const ProvisioningArtifactType = @import("provisioning_artifact_type.zig").ProvisioningArtifactType;

/// Information about a provisioning artifact (also known as a version) for a
/// product.
pub const ProvisioningArtifactDetail = struct {
    /// Indicates whether the product version is active.
    active: ?bool,

    /// The UTC time stamp of the creation time.
    created_time: ?i64,

    /// The description of the provisioning artifact.
    description: ?[]const u8,

    /// Information set by the administrator to provide guidance to end users about
    /// which provisioning artifacts to use.
    guidance: ?ProvisioningArtifactGuidance,

    /// The identifier of the provisioning artifact.
    id: ?[]const u8,

    /// The name of the provisioning artifact.
    name: ?[]const u8,

    /// Specifies the revision of the external artifact that was used to
    /// automatically sync the Service Catalog product
    /// and create the provisioning artifact. Service Catalog includes this response
    /// parameter as a high level
    /// field to the existing `ProvisioningArtifactDetail` type, which is returned
    /// as part of the
    /// response for `CreateProduct`, `UpdateProduct`, `DescribeProductAsAdmin`,
    /// `DescribeProvisioningArtifact`, `ListProvisioningArtifact`,
    /// and `UpdateProvisioningArticat` APIs.
    ///
    /// This field only exists for Repo-Synced products.
    source_revision: ?[]const u8,

    /// The type of provisioning artifact.
    ///
    /// * `CLOUD_FORMATION_TEMPLATE` - CloudFormation template
    ///
    /// * `TERRAFORM_OPEN_SOURCE` - Terraform Open Source configuration file
    ///
    /// * `TERRAFORM_CLOUD` - Terraform Cloud configuration file
    ///
    /// * `EXTERNAL` - External configuration file
    type: ?ProvisioningArtifactType,

    pub const json_field_names = .{
        .active = "Active",
        .created_time = "CreatedTime",
        .description = "Description",
        .guidance = "Guidance",
        .id = "Id",
        .name = "Name",
        .source_revision = "SourceRevision",
        .type = "Type",
    };
};
