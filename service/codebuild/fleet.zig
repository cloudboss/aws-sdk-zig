const ComputeConfiguration = @import("compute_configuration.zig").ComputeConfiguration;
const ComputeType = @import("compute_type.zig").ComputeType;
const EnvironmentType = @import("environment_type.zig").EnvironmentType;
const FleetOverflowBehavior = @import("fleet_overflow_behavior.zig").FleetOverflowBehavior;
const ProxyConfiguration = @import("proxy_configuration.zig").ProxyConfiguration;
const ScalingConfigurationOutput = @import("scaling_configuration_output.zig").ScalingConfigurationOutput;
const FleetStatus = @import("fleet_status.zig").FleetStatus;
const Tag = @import("tag.zig").Tag;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// A set of dedicated instances for your build environment.
pub const Fleet = struct {
    /// The ARN of the compute fleet.
    arn: ?[]const u8,

    /// The initial number of machines allocated to the compute ﬂeet, which deﬁnes
    /// the number of builds that can run in parallel.
    base_capacity: ?i32,

    /// The compute configuration of the compute fleet. This is only required if
    /// `computeType` is set to `ATTRIBUTE_BASED_COMPUTE` or `CUSTOM_INSTANCE_TYPE`.
    compute_configuration: ?ComputeConfiguration,

    /// Information about the compute resources the compute fleet uses. Available
    /// values
    /// include:
    ///
    /// * `ATTRIBUTE_BASED_COMPUTE`: Specify the amount of vCPUs, memory, disk
    ///   space, and the type of machine.
    ///
    /// If you use `ATTRIBUTE_BASED_COMPUTE`, you must define your attributes by
    /// using `computeConfiguration`. CodeBuild
    /// will select the cheapest instance that satisfies your specified attributes.
    /// For more information, see [Reserved capacity environment
    /// types](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html#environment-reserved-capacity.types) in the *CodeBuild User Guide*.
    ///
    /// * `CUSTOM_INSTANCE_TYPE`: Specify the instance type for your compute fleet.
    ///   For a list of supported instance types, see [Supported instance families
    /// ](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html#environment-reserved-capacity.instance-types) in the *CodeBuild User Guide*.
    ///
    /// * `BUILD_GENERAL1_SMALL`: Use up to 4 GiB memory and 2 vCPUs for
    /// builds.
    ///
    /// * `BUILD_GENERAL1_MEDIUM`: Use up to 8 GiB memory and 4 vCPUs for
    /// builds.
    ///
    /// * `BUILD_GENERAL1_LARGE`: Use up to 16 GiB memory and 8 vCPUs for
    /// builds, depending on your environment type.
    ///
    /// * `BUILD_GENERAL1_XLARGE`: Use up to 72 GiB memory and 36 vCPUs for
    /// builds, depending on your environment type.
    ///
    /// * `BUILD_GENERAL1_2XLARGE`: Use up to 144 GiB memory, 72 vCPUs, and
    /// 824 GB of SSD storage for builds. This compute type supports Docker images
    /// up to
    /// 100 GB uncompressed.
    ///
    /// * `BUILD_LAMBDA_1GB`: Use up to 1 GiB memory for
    /// builds. Only available for environment type `LINUX_LAMBDA_CONTAINER` and
    /// `ARM_LAMBDA_CONTAINER`.
    ///
    /// * `BUILD_LAMBDA_2GB`: Use up to 2 GiB memory for
    /// builds. Only available for environment type `LINUX_LAMBDA_CONTAINER` and
    /// `ARM_LAMBDA_CONTAINER`.
    ///
    /// * `BUILD_LAMBDA_4GB`: Use up to 4 GiB memory for
    /// builds. Only available for environment type `LINUX_LAMBDA_CONTAINER` and
    /// `ARM_LAMBDA_CONTAINER`.
    ///
    /// * `BUILD_LAMBDA_8GB`: Use up to 8 GiB memory for
    /// builds. Only available for environment type `LINUX_LAMBDA_CONTAINER` and
    /// `ARM_LAMBDA_CONTAINER`.
    ///
    /// * `BUILD_LAMBDA_10GB`: Use up to 10 GiB memory for
    /// builds. Only available for environment type `LINUX_LAMBDA_CONTAINER` and
    /// `ARM_LAMBDA_CONTAINER`.
    ///
    /// If you use `BUILD_GENERAL1_SMALL`:
    ///
    /// * For environment type `LINUX_CONTAINER`, you can use up to 4 GiB
    /// memory and 2 vCPUs for builds.
    ///
    /// * For environment type `LINUX_GPU_CONTAINER`, you can use up to 16
    /// GiB memory, 4 vCPUs, and 1 NVIDIA A10G Tensor Core GPU for builds.
    ///
    /// * For environment type `ARM_CONTAINER`, you can use up to 4 GiB
    /// memory and 2 vCPUs on ARM-based processors for builds.
    ///
    /// If you use `BUILD_GENERAL1_LARGE`:
    ///
    /// * For environment type `LINUX_CONTAINER`, you can use up to 16 GiB
    /// memory and 8 vCPUs for builds.
    ///
    /// * For environment type `LINUX_GPU_CONTAINER`, you can use up to 255
    /// GiB memory, 32 vCPUs, and 4 NVIDIA Tesla V100 GPUs for builds.
    ///
    /// * For environment type `ARM_CONTAINER`, you can use up to 16 GiB
    /// memory and 8 vCPUs on ARM-based processors for builds.
    ///
    /// For more information, see [On-demand environment
    /// types](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html#environment.types)
    /// in the *CodeBuild User Guide.*
    compute_type: ?ComputeType,

    /// The time at which the compute fleet was created.
    created: ?i64,

    /// The environment type of the compute fleet.
    ///
    /// * The environment type `ARM_CONTAINER` is available only in regions
    /// US East (N. Virginia), US East (Ohio), US West (Oregon), EU (Ireland),
    /// Asia Pacific (Mumbai), Asia Pacific (Tokyo), Asia Pacific (Singapore), Asia
    /// Pacific (Sydney),
    /// EU (Frankfurt), and South America (São Paulo).
    ///
    /// * The environment type `ARM_EC2` is available only in regions
    /// US East (N. Virginia), US East (Ohio), US West (Oregon), EU (Ireland),
    /// EU (Frankfurt), Asia Pacific (Tokyo),
    /// Asia Pacific (Singapore), Asia Pacific (Sydney), South America (São Paulo),
    /// and
    /// Asia Pacific (Mumbai).
    ///
    /// * The environment type `LINUX_CONTAINER` is available only in regions
    /// US East (N. Virginia), US East (Ohio), US West (Oregon), EU (Ireland),
    /// EU (Frankfurt), Asia Pacific (Tokyo),
    /// Asia Pacific (Singapore), Asia Pacific (Sydney), South America (São Paulo),
    /// and
    /// Asia Pacific (Mumbai).
    ///
    /// * The environment type `LINUX_EC2` is available only in regions
    /// US East (N. Virginia), US East (Ohio), US West (Oregon), EU (Ireland),
    /// EU (Frankfurt), Asia Pacific (Tokyo),
    /// Asia Pacific (Singapore), Asia Pacific (Sydney), South America (São Paulo),
    /// and
    /// Asia Pacific (Mumbai).
    ///
    /// * The environment type `LINUX_GPU_CONTAINER` is available only in
    /// regions US East (N. Virginia), US East (Ohio), US West (Oregon), EU
    /// (Ireland),
    /// EU (Frankfurt), Asia Pacific (Tokyo), and Asia Pacific (Sydney).
    ///
    /// * The environment type `MAC_ARM` is available for Medium fleets only in
    /// regions US East (N. Virginia), US East (Ohio), US West (Oregon), Asia
    /// Pacific (Sydney),
    /// and EU (Frankfurt)
    ///
    /// * The environment type `MAC_ARM` is available for Large fleets only in
    /// regions US East (N. Virginia), US East (Ohio), US West (Oregon), and Asia
    /// Pacific (Sydney).
    ///
    /// * The environment type `WINDOWS_EC2` is available only in regions
    /// US East (N. Virginia), US East (Ohio), US West (Oregon), EU (Ireland),
    /// EU (Frankfurt), Asia Pacific (Tokyo),
    /// Asia Pacific (Singapore), Asia Pacific (Sydney), South America (São Paulo),
    /// and
    /// Asia Pacific (Mumbai).
    ///
    /// * The environment type `WINDOWS_SERVER_2019_CONTAINER` is available only in
    ///   regions
    /// US East (N. Virginia), US East (Ohio), US West (Oregon), Asia Pacific
    /// (Sydney),
    /// Asia Pacific (Tokyo), Asia Pacific (Mumbai) and
    /// EU (Ireland).
    ///
    /// * The environment type `WINDOWS_SERVER_2022_CONTAINER` is available only in
    ///   regions
    /// US East (N. Virginia), US East (Ohio), US West (Oregon), EU (Ireland), EU
    /// (Frankfurt),
    /// Asia Pacific (Sydney), Asia Pacific (Singapore), Asia Pacific (Tokyo), South
    /// America (São Paulo) and
    /// Asia Pacific (Mumbai).
    ///
    /// For more information, see [Build environment compute
    /// types](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html) in the *CodeBuild
    /// user guide*.
    environment_type: ?EnvironmentType,

    /// The service role associated with the compute fleet. For more information,
    /// see [
    /// Allow a user to add a permission policy for a fleet service
    /// role](https://docs.aws.amazon.com/codebuild/latest/userguide/auth-and-access-control-iam-identity-based-access-control.html#customer-managed-policies-example-permission-policy-fleet-service-role.html) in the *CodeBuild User Guide*.
    fleet_service_role: ?[]const u8,

    /// The ID of the compute fleet.
    id: ?[]const u8,

    /// The Amazon Machine Image (AMI) of the compute fleet.
    image_id: ?[]const u8,

    /// The time at which the compute fleet was last modified.
    last_modified: ?i64,

    /// The name of the compute fleet.
    name: ?[]const u8,

    /// The compute fleet overflow behavior.
    ///
    /// * For overflow behavior `QUEUE`, your overflow builds need to wait on
    /// the existing fleet instance to become available.
    ///
    /// * For overflow behavior `ON_DEMAND`, your overflow builds run on CodeBuild
    ///   on-demand.
    ///
    /// If you choose to set your overflow behavior to on-demand while creating a
    /// VPC-connected
    /// fleet, make sure that you add the required VPC permissions to your project
    /// service role. For more
    /// information, see [Example
    /// policy statement to allow CodeBuild access to Amazon Web Services services
    /// required to create a VPC network
    /// interface](https://docs.aws.amazon.com/codebuild/latest/userguide/auth-and-access-control-iam-identity-based-access-control.html#customer-managed-policies-example-create-vpc-network-interface).
    overflow_behavior: ?FleetOverflowBehavior,

    /// The proxy configuration of the compute fleet.
    proxy_configuration: ?ProxyConfiguration,

    /// The scaling configuration of the compute fleet.
    scaling_configuration: ?ScalingConfigurationOutput,

    /// The status of the compute fleet.
    status: ?FleetStatus,

    /// A list of tag key and value pairs associated with this compute fleet.
    ///
    /// These tags are available for use by Amazon Web Services services that
    /// support CodeBuild build project
    /// tags.
    tags: ?[]const Tag,

    vpc_config: ?VpcConfig,

    pub const json_field_names = .{
        .arn = "arn",
        .base_capacity = "baseCapacity",
        .compute_configuration = "computeConfiguration",
        .compute_type = "computeType",
        .created = "created",
        .environment_type = "environmentType",
        .fleet_service_role = "fleetServiceRole",
        .id = "id",
        .image_id = "imageId",
        .last_modified = "lastModified",
        .name = "name",
        .overflow_behavior = "overflowBehavior",
        .proxy_configuration = "proxyConfiguration",
        .scaling_configuration = "scalingConfiguration",
        .status = "status",
        .tags = "tags",
        .vpc_config = "vpcConfig",
    };
};
