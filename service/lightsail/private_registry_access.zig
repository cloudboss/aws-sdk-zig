const ContainerServiceECRImagePullerRole = @import("container_service_ecr_image_puller_role.zig").ContainerServiceECRImagePullerRole;

/// Describes the configuration for an Amazon Lightsail container service to
/// access private container image repositories, such as Amazon Elastic
/// Container Registry (Amazon ECR) private repositories.
///
/// For more information, see [Configuring access to an Amazon ECR private
/// repository for an Amazon Lightsail container
/// service](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-container-service-ecr-private-repo-access) in the *Amazon Lightsail Developer Guide*.
pub const PrivateRegistryAccess = struct {
    /// An object that describes the activation status of the role that you can use
    /// to grant a
    /// Lightsail container service access to Amazon ECR private
    /// repositories. If the role is activated, the Amazon Resource Name (ARN) of
    /// the role is also
    /// listed.
    ecr_image_puller_role: ?ContainerServiceECRImagePullerRole = null,

    pub const json_field_names = .{
        .ecr_image_puller_role = "ecrImagePullerRole",
    };
};
