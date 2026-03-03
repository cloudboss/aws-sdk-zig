const ContainerServiceECRImagePullerRoleRequest = @import("container_service_ecr_image_puller_role_request.zig").ContainerServiceECRImagePullerRoleRequest;

/// Describes a request to configure an Amazon Lightsail container service to
/// access private container image repositories, such as Amazon Elastic
/// Container Registry (Amazon ECR) private repositories.
///
/// For more information, see [Configuring access to an Amazon ECR private
/// repository for an Amazon Lightsail container
/// service](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-container-service-ecr-private-repo-access) in the *Amazon Lightsail Developer Guide*.
pub const PrivateRegistryAccessRequest = struct {
    /// An object to describe a request to activate or deactivate the role that you
    /// can use to
    /// grant an Amazon Lightsail container service access to Amazon Elastic
    /// Container Registry
    /// (Amazon ECR) private repositories.
    ecr_image_puller_role: ?ContainerServiceECRImagePullerRoleRequest = null,

    pub const json_field_names = .{
        .ecr_image_puller_role = "ecrImagePullerRole",
    };
};
