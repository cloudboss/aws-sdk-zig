const aws = @import("aws");

const SessionCommand = @import("session_command.zig").SessionCommand;
const ConnectionsList = @import("connections_list.zig").ConnectionsList;
const SessionStatus = @import("session_status.zig").SessionStatus;
const WorkerType = @import("worker_type.zig").WorkerType;

/// The period in which a remote Spark runtime environment is running.
pub const Session = struct {
    /// The command object.See SessionCommand.
    command: ?SessionCommand,

    /// The date and time that this session is completed.
    completed_on: ?i64,

    /// The number of connections used for the session.
    connections: ?ConnectionsList,

    /// The time and date when the session was created.
    created_on: ?i64,

    /// A map array of key-value pairs. Max is 75 pairs.
    default_arguments: ?[]const aws.map.StringMapEntry,

    /// The description of the session.
    description: ?[]const u8,

    /// The DPUs consumed by the session (formula: ExecutionTime * MaxCapacity).
    dpu_seconds: ?f64,

    /// The error message displayed during the session.
    error_message: ?[]const u8,

    /// The total time the session ran for.
    execution_time: ?f64,

    /// The Glue version determines the versions of Apache Spark and Python that
    /// Glue supports.
    /// The GlueVersion must be greater than 2.0.
    glue_version: ?[]const u8,

    /// The ID of the session.
    id: ?[]const u8,

    /// The number of minutes when idle before the session times out.
    idle_timeout: ?i32,

    /// The number of Glue data processing units (DPUs) that can be allocated when
    /// the job runs.
    /// A DPU is a relative measure of processing power that consists of 4 vCPUs of
    /// compute capacity and 16 GB memory.
    max_capacity: ?f64,

    /// The number of workers of a defined `WorkerType` to use for the session.
    number_of_workers: ?i32,

    /// The name of an Glue usage profile associated with the session.
    profile_name: ?[]const u8,

    /// The code execution progress of the session.
    progress: f64 = 0,

    /// The name or Amazon Resource Name (ARN) of the IAM role associated with the
    /// Session.
    role: ?[]const u8,

    /// The name of the SecurityConfiguration structure to be used with the session.
    security_configuration: ?[]const u8,

    /// The session status.
    status: ?SessionStatus,

    /// The type of predefined worker that is allocated when a session runs. Accepts
    /// a value of `G.1X`, `G.2X`, `G.4X`, or `G.8X` for Spark sessions. Accepts the
    /// value `Z.2X` for Ray sessions.
    worker_type: ?WorkerType,

    pub const json_field_names = .{
        .command = "Command",
        .completed_on = "CompletedOn",
        .connections = "Connections",
        .created_on = "CreatedOn",
        .default_arguments = "DefaultArguments",
        .description = "Description",
        .dpu_seconds = "DPUSeconds",
        .error_message = "ErrorMessage",
        .execution_time = "ExecutionTime",
        .glue_version = "GlueVersion",
        .id = "Id",
        .idle_timeout = "IdleTimeout",
        .max_capacity = "MaxCapacity",
        .number_of_workers = "NumberOfWorkers",
        .profile_name = "ProfileName",
        .progress = "Progress",
        .role = "Role",
        .security_configuration = "SecurityConfiguration",
        .status = "Status",
        .worker_type = "WorkerType",
    };
};
