const aws = @import("aws");

const ContainerServiceDeployment = @import("container_service_deployment.zig").ContainerServiceDeployment;
const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const ContainerServicePowerName = @import("container_service_power_name.zig").ContainerServicePowerName;
const PrivateRegistryAccess = @import("private_registry_access.zig").PrivateRegistryAccess;
const ResourceType = @import("resource_type.zig").ResourceType;
const ContainerServiceState = @import("container_service_state.zig").ContainerServiceState;
const ContainerServiceStateDetail = @import("container_service_state_detail.zig").ContainerServiceStateDetail;
const Tag = @import("tag.zig").Tag;

/// Describes an Amazon Lightsail container service.
pub const ContainerService = struct {
    /// The Amazon Resource Name (ARN) of the container service.
    arn: ?[]const u8 = null,

    /// The name of the container service.
    container_service_name: ?[]const u8 = null,

    /// The timestamp when the container service was created.
    created_at: ?i64 = null,

    /// An object that describes the current container deployment of the container
    /// service.
    current_deployment: ?ContainerServiceDeployment = null,

    /// A Boolean value indicating whether the container service is disabled.
    is_disabled: ?bool = null,

    /// An object that describes the location of the container service, such as the
    /// Amazon Web Services Region and Availability Zone.
    location: ?ResourceLocation = null,

    /// An object that describes the next deployment of the container service.
    ///
    /// This value is `null` when there is no deployment in a `pending`
    /// state.
    next_deployment: ?ContainerServiceDeployment = null,

    /// The power specification of the container service.
    ///
    /// The power specifies the amount of RAM, the number of vCPUs, and the base
    /// price of the
    /// container service.
    power: ?ContainerServicePowerName = null,

    /// The ID of the power of the container service.
    power_id: ?[]const u8 = null,

    /// The principal ARN of the container service.
    ///
    /// The principal ARN can be used to create a trust relationship between your
    /// standard Amazon Web Services account and your Lightsail container service.
    /// This allows you to give your
    /// service permission to access resources in your standard Amazon Web Services
    /// account.
    principal_arn: ?[]const u8 = null,

    /// The private domain name of the container service.
    ///
    /// The private domain name is accessible only by other resources within the
    /// default virtual
    /// private cloud (VPC) of your Lightsail account.
    private_domain_name: ?[]const u8 = null,

    /// An object that describes the configuration for the container service to
    /// access private
    /// container image repositories, such as Amazon Elastic Container Registry
    /// (Amazon ECR) private
    /// repositories.
    ///
    /// For more information, see [Configuring access to an Amazon ECR private
    /// repository for an Amazon Lightsail container
    /// service](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-container-service-ecr-private-repo-access) in the *Amazon Lightsail Developer Guide*.
    private_registry_access: ?PrivateRegistryAccess = null,

    /// The public domain name of the container service, such as `example.com` and
    /// `www.example.com`.
    ///
    /// You can specify up to four public domain names for a container service. The
    /// domain names
    /// that you specify are used when you create a deployment with a container
    /// configured as the
    /// public endpoint of your container service.
    ///
    /// If you don't specify public domain names, then you can use the default
    /// domain of the
    /// container service.
    ///
    /// You must create and validate an SSL/TLS certificate before you can use
    /// public domain
    /// names with your container service. Use the `CreateCertificate` action to
    /// create a
    /// certificate for the public domain names you want to use with your container
    /// service.
    ///
    /// See `CreateContainerService` or `UpdateContainerService` for
    /// information about how to specify public domain names for your Lightsail
    /// container
    /// service.
    public_domain_names: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The Lightsail resource type of the container service.
    resource_type: ?ResourceType = null,

    /// The scale specification of the container service.
    ///
    /// The scale specifies the allocated compute nodes of the container service.
    scale: ?i32 = null,

    /// The current state of the container service.
    ///
    /// The following container service states are possible:
    ///
    /// * `PENDING` - The container service is being created.
    ///
    /// * `READY` - The container service is running but it does not have an active
    /// container deployment.
    ///
    /// * `DEPLOYING` - The container service is launching a container
    /// deployment.
    ///
    /// * `RUNNING` - The container service is running and it has an active
    ///   container
    /// deployment.
    ///
    /// * `UPDATING` - The container service capacity or its custom domains are
    ///   being
    /// updated.
    ///
    /// * `DELETING` - The container service is being deleted.
    ///
    /// * `DISABLED` - The container service is disabled, and its active deployment
    /// and containers, if any, are shut down.
    state: ?ContainerServiceState = null,

    /// An object that describes the current state of the container service.
    ///
    /// The state detail is populated only when a container service is in a
    /// `PENDING`, `DEPLOYING`, or `UPDATING` state.
    state_detail: ?ContainerServiceStateDetail = null,

    /// The tag keys and optional values for the resource. For more information
    /// about tags in
    /// Lightsail, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-tags).
    tags: ?[]const Tag = null,

    /// The publicly accessible URL of the container service.
    ///
    /// If no public endpoint is specified in the `currentDeployment`, this URL
    /// returns
    /// a 404 response.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .container_service_name = "containerServiceName",
        .created_at = "createdAt",
        .current_deployment = "currentDeployment",
        .is_disabled = "isDisabled",
        .location = "location",
        .next_deployment = "nextDeployment",
        .power = "power",
        .power_id = "powerId",
        .principal_arn = "principalArn",
        .private_domain_name = "privateDomainName",
        .private_registry_access = "privateRegistryAccess",
        .public_domain_names = "publicDomainNames",
        .resource_type = "resourceType",
        .scale = "scale",
        .state = "state",
        .state_detail = "stateDetail",
        .tags = "tags",
        .url = "url",
    };
};
