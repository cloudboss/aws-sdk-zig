const BrokerState = @import("broker_state.zig").BrokerState;
const DeploymentMode = @import("deployment_mode.zig").DeploymentMode;
const EngineType = @import("engine_type.zig").EngineType;

/// Returns information about all brokers.
pub const BrokerSummary = struct {
    /// The broker's Amazon Resource Name (ARN).
    broker_arn: ?[]const u8 = null,

    /// The unique ID that Amazon MQ generates for the broker.
    broker_id: ?[]const u8 = null,

    /// The broker's name. This value is unique in your Amazon Web Services account,
    /// 1-50 characters long, and containing only letters, numbers, dashes, and
    /// underscores, and must not contain white spaces, brackets, wildcard
    /// characters, or special characters.
    broker_name: ?[]const u8 = null,

    /// The broker's status.
    broker_state: ?BrokerState = null,

    /// The time when the broker was created.
    created: ?i64 = null,

    /// The broker's deployment mode.
    deployment_mode: DeploymentMode,

    /// The type of broker engine.
    engine_type: EngineType,

    /// The broker's instance type.
    host_instance_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .broker_arn = "BrokerArn",
        .broker_id = "BrokerId",
        .broker_name = "BrokerName",
        .broker_state = "BrokerState",
        .created = "Created",
        .deployment_mode = "DeploymentMode",
        .engine_type = "EngineType",
        .host_instance_type = "HostInstanceType",
    };
};
