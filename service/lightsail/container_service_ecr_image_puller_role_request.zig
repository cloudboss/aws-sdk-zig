/// Describes a request to activate or deactivate the role that you can use to
/// grant an
/// Amazon Lightsail container service access to Amazon Elastic Container
/// Registry (Amazon ECR) private repositories.
///
/// When activated, Lightsail creates an Identity and Access Management (IAM)
/// role
/// for the specified Lightsail container service. You can use the ARN of the
/// role to create a
/// trust relationship between your Lightsail container service and an Amazon
/// ECR private repository in your Amazon Web Services account. This allows your
/// container
/// service to pull images from Amazon ECR private repositories. For more
/// information, see
/// [Configuring access to an Amazon ECR private repository for an Amazon
/// Lightsail container
/// service](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-container-service-ecr-private-repo-access) in the *Amazon Lightsail Developer Guide*.
pub const ContainerServiceECRImagePullerRoleRequest = struct {
    /// A Boolean value that indicates whether to activate the role.
    is_active: ?bool = null,

    pub const json_field_names = .{
        .is_active = "isActive",
    };
};
