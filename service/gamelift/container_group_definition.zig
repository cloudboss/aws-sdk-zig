const ContainerGroupType = @import("container_group_type.zig").ContainerGroupType;
const GameServerContainerDefinition = @import("game_server_container_definition.zig").GameServerContainerDefinition;
const ContainerOperatingSystem = @import("container_operating_system.zig").ContainerOperatingSystem;
const ContainerGroupDefinitionStatus = @import("container_group_definition_status.zig").ContainerGroupDefinitionStatus;
const SupportContainerDefinition = @import("support_container_definition.zig").SupportContainerDefinition;

/// The properties that describe a container group resource. You can update all
/// properties of
/// a container group definition properties. Updates to a container group
/// definition are saved as
/// new versions.
///
/// **Used with:**
/// [CreateContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_CreateContainerGroupDefinition.html)
///
/// **Returned by:**
/// [DescribeContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_DescribeContainerGroupDefinition.html),
/// [ListContainerGroupDefinitions](https://docs.aws.amazon.com/gamelift/latest/apireference/API_ListContainerGroupDefinitions.html),
/// [UpdateContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_UpdateContainerGroupDefinition.html)
pub const ContainerGroupDefinition = struct {
    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to an Amazon GameLift Servers `ContainerGroupDefinition`
    /// resource. It uniquely identifies
    /// the resource across all Amazon Web Services Regions. Format is
    /// `arn:aws:gamelift:[region]::containergroupdefinition/[container group
    /// definition name]:[version]`.
    container_group_definition_arn: ?[]const u8 = null,

    /// The type of container group. Container group type determines how Amazon
    /// GameLift Servers deploys the
    /// container group on each fleet instance.
    container_group_type: ?ContainerGroupType = null,

    /// A time stamp indicating when this data object was created. Format is a
    /// number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`).
    creation_time: ?i64 = null,

    /// The definition for the game server container in this group. This property is
    /// used only
    /// when the container group type is `GAME_SERVER`. This container definition
    /// specifies
    /// a container image with the game server build.
    game_server_container_definition: ?GameServerContainerDefinition = null,

    /// A descriptive identifier for the container group definition. The name value
    /// is unique in an Amazon Web Services Region.
    name: []const u8,

    /// The platform that all containers in the container group definition run on.
    ///
    /// Amazon Linux 2 (AL2) will reach end of support on 6/30/2026. See more
    /// details in the [Amazon Linux 2
    /// FAQs](http://aws.amazon.com/amazon-linux-2/faqs/). For game
    /// servers that are hosted on AL2 and use server SDK version 4.x for Amazon
    /// GameLift Servers, first update the game
    /// server build to server SDK 5.x, and then deploy to AL2023 instances. See [
    /// Migrate to
    /// server SDK version
    /// 5.](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-serversdk5-migration.html)
    operating_system: ?ContainerOperatingSystem = null,

    /// Current status of the container group definition resource. Values include:
    ///
    /// * `COPYING` -- Amazon GameLift Servers is in the process of making copies of
    ///   all container
    /// images that are defined in the group. While in this state, the resource
    /// can't be used to
    /// create a container fleet.
    ///
    /// * `READY` -- Amazon GameLift Servers has copied the registry images for all
    ///   containers that
    /// are defined in the group. You can use a container group definition in this
    /// status to
    /// create a container fleet.
    ///
    /// * `FAILED` -- Amazon GameLift Servers failed to create a valid container
    ///   group definition
    /// resource. For more details on the cause of the failure, see `StatusReason`.
    /// A
    /// container group definition resource in failed status will be deleted within
    /// a few
    /// minutes.
    status: ?ContainerGroupDefinitionStatus = null,

    /// Additional information about a container group definition that's in `FAILED`
    /// status. Possible reasons include:
    ///
    /// * An internal issue prevented Amazon GameLift Servers from creating
    /// the container group definition resource. Delete the failed resource and call
    /// [CreateContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_CreateContainerGroupDefinition.html)again.
    ///
    /// * An access-denied message means that you don't have permissions to access
    ///   the container image on ECR. See
    /// [
    /// IAM permission
    /// examples](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-iam-policy-examples.html.html)
    /// for help setting up required IAM permissions for Amazon GameLift Servers.
    ///
    /// * The `ImageUri` value for at least one
    /// of the containers in the container group definition was invalid or not found
    /// in the current
    /// Amazon Web Services account.
    ///
    /// * At least one
    /// of the container images referenced in the container group definition exceeds
    /// the
    /// allowed size. For size limits, see [
    /// Amazon GameLift Servers endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/gamelift.html).
    ///
    /// * At least one of the container images referenced in the
    /// container group definition uses a different operating system than the one
    /// defined for the container group.
    status_reason: ?[]const u8 = null,

    /// The set of definitions for support containers in this group. A container
    /// group definition
    /// might have zero support container definitions. Support container can be used
    /// in any type of
    /// container group.
    support_container_definitions: ?[]const SupportContainerDefinition = null,

    /// The amount of memory (in MiB) on a fleet instance to allocate for the
    /// container group. All
    /// containers in the group share these resources.
    ///
    /// You can set a limit for each container definition in the group. If
    /// individual containers
    /// have limits, this total value must be greater than any individual
    /// container's memory
    /// limit.
    total_memory_limit_mebibytes: ?i32 = null,

    /// The amount of vCPU units on a fleet instance to allocate for the container
    /// group (1 vCPU
    /// is equal to 1024 CPU units). All containers in the group share these
    /// resources. You can set a
    /// limit for each container definition in the group. If individual containers
    /// have limits, this
    /// total value must be equal to or greater than the sum of the limits for each
    /// container in the
    /// group.
    total_vcpu_limit: ?f64 = null,

    /// An optional description that was provided for a container group definition
    /// update. Each
    /// version can have a unique description.
    version_description: ?[]const u8 = null,

    /// Indicates the version of a particular container group definition. This
    /// number is
    /// incremented automatically when you update a container group definition. You
    /// can view, update,
    /// or delete individual versions or the entire container group definition.
    version_number: ?i32 = null,

    pub const json_field_names = .{
        .container_group_definition_arn = "ContainerGroupDefinitionArn",
        .container_group_type = "ContainerGroupType",
        .creation_time = "CreationTime",
        .game_server_container_definition = "GameServerContainerDefinition",
        .name = "Name",
        .operating_system = "OperatingSystem",
        .status = "Status",
        .status_reason = "StatusReason",
        .support_container_definitions = "SupportContainerDefinitions",
        .total_memory_limit_mebibytes = "TotalMemoryLimitMebibytes",
        .total_vcpu_limit = "TotalVcpuLimit",
        .version_description = "VersionDescription",
        .version_number = "VersionNumber",
    };
};
