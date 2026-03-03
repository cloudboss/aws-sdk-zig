const AccessEndpoint = @import("access_endpoint.zig").AccessEndpoint;
const DomainJoinInfo = @import("domain_join_info.zig").DomainJoinInfo;
const ResourceError = @import("resource_error.zig").ResourceError;
const LatestAppstreamAgentVersion = @import("latest_appstream_agent_version.zig").LatestAppstreamAgentVersion;
const NetworkAccessConfiguration = @import("network_access_configuration.zig").NetworkAccessConfiguration;
const PlatformType = @import("platform_type.zig").PlatformType;
const VolumeConfig = @import("volume_config.zig").VolumeConfig;
const ImageBuilderState = @import("image_builder_state.zig").ImageBuilderState;
const ImageBuilderStateChangeReason = @import("image_builder_state_change_reason.zig").ImageBuilderStateChangeReason;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Describes a virtual machine that is used to create an image.
pub const ImageBuilder = struct {
    /// The list of virtual private cloud (VPC) interface endpoint objects.
    /// Administrators can connect to the image builder only through the specified
    /// endpoints.
    access_endpoints: ?[]const AccessEndpoint = null,

    /// The version of the WorkSpaces Applications agent that is currently being
    /// used by the image builder.
    appstream_agent_version: ?[]const u8 = null,

    /// The ARN for the image builder.
    arn: ?[]const u8 = null,

    /// The time stamp when the image builder was created.
    created_time: ?i64 = null,

    /// The description to display.
    description: ?[]const u8 = null,

    /// The image builder name to display.
    display_name: ?[]const u8 = null,

    /// The name of the directory and organizational unit (OU) to use to join the
    /// image builder to a Microsoft Active Directory domain.
    domain_join_info: ?DomainJoinInfo = null,

    /// Enables or disables default internet access for the image builder.
    enable_default_internet_access: ?bool = null,

    /// The ARN of the IAM role that is applied to the image builder. To assume a
    /// role, the image builder calls the AWS Security Token Service (STS)
    /// `AssumeRole` API operation and passes the ARN of the role to use. The
    /// operation creates a new session with temporary credentials. WorkSpaces
    /// Applications retrieves the temporary credentials and creates the
    /// **appstream_machine_role** credential profile on the instance.
    ///
    /// For more information, see [Using an IAM Role to Grant Permissions to
    /// Applications and Scripts Running on WorkSpaces Applications Streaming
    /// Instances](https://docs.aws.amazon.com/appstream2/latest/developerguide/using-iam-roles-to-grant-permissions-to-applications-scripts-streaming-instances.html) in the *Amazon WorkSpaces Applications Administration Guide*.
    iam_role_arn: ?[]const u8 = null,

    /// The ARN of the image from which this builder was created.
    image_arn: ?[]const u8 = null,

    /// The image builder errors.
    image_builder_errors: ?[]const ResourceError = null,

    /// The instance type for the image builder. The following instance types are
    /// available:
    ///
    /// * stream.standard.small
    ///
    /// * stream.standard.medium
    ///
    /// * stream.standard.large
    ///
    /// * stream.compute.large
    ///
    /// * stream.compute.xlarge
    ///
    /// * stream.compute.2xlarge
    ///
    /// * stream.compute.4xlarge
    ///
    /// * stream.compute.8xlarge
    ///
    /// * stream.memory.large
    ///
    /// * stream.memory.xlarge
    ///
    /// * stream.memory.2xlarge
    ///
    /// * stream.memory.4xlarge
    ///
    /// * stream.memory.8xlarge
    ///
    /// * stream.memory.z1d.large
    ///
    /// * stream.memory.z1d.xlarge
    ///
    /// * stream.memory.z1d.2xlarge
    ///
    /// * stream.memory.z1d.3xlarge
    ///
    /// * stream.memory.z1d.6xlarge
    ///
    /// * stream.memory.z1d.12xlarge
    ///
    /// * stream.graphics.g4dn.xlarge
    ///
    /// * stream.graphics.g4dn.2xlarge
    ///
    /// * stream.graphics.g4dn.4xlarge
    ///
    /// * stream.graphics.g4dn.8xlarge
    ///
    /// * stream.graphics.g4dn.12xlarge
    ///
    /// * stream.graphics.g4dn.16xlarge
    ///
    /// * stream.graphics.g5.xlarge
    ///
    /// * stream.graphics.g5.2xlarge
    ///
    /// * stream.graphics.g5.4xlarge
    ///
    /// * stream.graphics.g5.8xlarge
    ///
    /// * stream.graphics.g5.16xlarge
    ///
    /// * stream.graphics.g5.12xlarge
    ///
    /// * stream.graphics.g5.24xlarge
    ///
    /// * stream.graphics.g6.xlarge
    ///
    /// * stream.graphics.g6.2xlarge
    ///
    /// * stream.graphics.g6.4xlarge
    ///
    /// * stream.graphics.g6.8xlarge
    ///
    /// * stream.graphics.g6.16xlarge
    ///
    /// * stream.graphics.g6.12xlarge
    ///
    /// * stream.graphics.g6.24xlarge
    ///
    /// * stream.graphics.gr6.4xlarge
    ///
    /// * stream.graphics.gr6.8xlarge
    ///
    /// * stream.graphics.g6f.large
    ///
    /// * stream.graphics.g6f.xlarge
    ///
    /// * stream.graphics.g6f.2xlarge
    ///
    /// * stream.graphics.g6f.4xlarge
    ///
    /// * stream.graphics.gr6f.4xlarge
    instance_type: ?[]const u8 = null,

    /// Indicates whether the image builder is using the latest WorkSpaces
    /// Applications agent version or not.
    latest_appstream_agent_version: ?LatestAppstreamAgentVersion = null,

    /// The name of the image builder.
    name: []const u8,

    network_access_configuration: ?NetworkAccessConfiguration = null,

    /// The operating system platform of the image builder.
    platform: ?PlatformType = null,

    /// The current configuration of the root volume for the image builder,
    /// including the storage size in GB.
    root_volume_config: ?VolumeConfig = null,

    /// The state of the image builder.
    state: ?ImageBuilderState = null,

    /// The reason why the last state change occurred.
    state_change_reason: ?ImageBuilderStateChangeReason = null,

    /// The VPC configuration of the image builder.
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .access_endpoints = "AccessEndpoints",
        .appstream_agent_version = "AppstreamAgentVersion",
        .arn = "Arn",
        .created_time = "CreatedTime",
        .description = "Description",
        .display_name = "DisplayName",
        .domain_join_info = "DomainJoinInfo",
        .enable_default_internet_access = "EnableDefaultInternetAccess",
        .iam_role_arn = "IamRoleArn",
        .image_arn = "ImageArn",
        .image_builder_errors = "ImageBuilderErrors",
        .instance_type = "InstanceType",
        .latest_appstream_agent_version = "LatestAppstreamAgentVersion",
        .name = "Name",
        .network_access_configuration = "NetworkAccessConfiguration",
        .platform = "Platform",
        .root_volume_config = "RootVolumeConfig",
        .state = "State",
        .state_change_reason = "StateChangeReason",
        .vpc_config = "VpcConfig",
    };
};
