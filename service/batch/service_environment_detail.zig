const aws = @import("aws");

const CapacityLimit = @import("capacity_limit.zig").CapacityLimit;
const ServiceEnvironmentType = @import("service_environment_type.zig").ServiceEnvironmentType;
const ServiceEnvironmentState = @import("service_environment_state.zig").ServiceEnvironmentState;
const ServiceEnvironmentStatus = @import("service_environment_status.zig").ServiceEnvironmentStatus;

/// Detailed information about a service environment, including its
/// configuration, state, and capacity limits.
pub const ServiceEnvironmentDetail = struct {
    /// The capacity limits for the service environment. This defines the maximum
    /// resources that can be used by service jobs in this environment.
    capacity_limits: []const CapacityLimit,

    /// The Amazon Resource Name (ARN) of the service environment.
    service_environment_arn: []const u8,

    /// The name of the service environment.
    service_environment_name: []const u8,

    /// The type of service environment. For SageMaker Training jobs, this value is
    /// `SAGEMAKER_TRAINING`.
    service_environment_type: ServiceEnvironmentType,

    /// The state of the service environment. Valid values are `ENABLED` and
    /// `DISABLED`.
    state: ?ServiceEnvironmentState = null,

    /// The current status of the service environment.
    status: ?ServiceEnvironmentStatus = null,

    /// The tags associated with the service environment. Each tag consists of a key
    /// and an optional value. For more information, see [Tagging your Batch
    /// resources](https://docs.aws.amazon.com/batch/latest/userguide/using-tags.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .capacity_limits = "capacityLimits",
        .service_environment_arn = "serviceEnvironmentArn",
        .service_environment_name = "serviceEnvironmentName",
        .service_environment_type = "serviceEnvironmentType",
        .state = "state",
        .status = "status",
        .tags = "tags",
    };
};
