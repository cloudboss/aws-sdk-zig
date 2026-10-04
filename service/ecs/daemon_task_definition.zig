const DaemonContainerDefinition = @import("daemon_container_definition.zig").DaemonContainerDefinition;
const DaemonIpcMode = @import("daemon_ipc_mode.zig").DaemonIpcMode;
const DaemonPidMode = @import("daemon_pid_mode.zig").DaemonPidMode;
const DaemonTaskDefinitionStatus = @import("daemon_task_definition_status.zig").DaemonTaskDefinitionStatus;
const DaemonVolume = @import("daemon_volume.zig").DaemonVolume;

/// The details of a daemon task definition. A daemon task definition is a
/// template that describes the containers that form a daemon. Daemons deploy
/// cross-cutting software agents independently across your Amazon ECS
/// infrastructure.
pub const DaemonTaskDefinition = struct {
    /// A list of container definitions in JSON format that describe the containers
    /// that make up the daemon task.
    container_definitions: ?[]const DaemonContainerDefinition = null,

    /// The number of CPU units used by the daemon task.
    cpu: ?[]const u8 = null,

    /// The full Amazon Resource Name (ARN) of the daemon task definition.
    daemon_task_definition_arn: ?[]const u8 = null,

    /// The Unix timestamp for the time when the daemon task definition delete was
    /// requested.
    delete_requested_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the task execution role that grants the
    /// Amazon ECS container agent permission to make Amazon Web Services API calls
    /// on your behalf.
    execution_role_arn: ?[]const u8 = null,

    /// The name of a family that this daemon task definition is registered to.
    family: ?[]const u8 = null,

    /// The IPC namespace mode for the daemon. The valid values are `none` and
    /// `shared`. The default is `none`.
    ///
    /// If `none` is specified or no value is provided, the daemon runs with its own
    /// IPC namespace, isolated from other tasks. If `shared` is specified, the
    /// daemon joins the host IPC namespace, making it accessible to non-daemon
    /// tasks that use `ipcMode: "host"` or other daemons that use `ipcMode:
    /// "shared"`.
    ipc_mode: ?DaemonIpcMode = null,

    /// The amount of memory (in MiB) used by the daemon task.
    memory: ?[]const u8 = null,

    /// The PID namespace mode for the daemon. The valid values are `none` and
    /// `shared`. The default is `none`.
    ///
    /// If `none` is specified or no value is provided, the daemon runs with its own
    /// PID namespace, isolated from other tasks. If `shared` is specified, the
    /// daemon joins the host PID namespace, making it accessible to non-daemon
    /// tasks that use `pidMode: "host"` or other daemons that use `pidMode:
    /// "shared"`.
    pid_mode: ?DaemonPidMode = null,

    /// The Unix timestamp for the time when the daemon task definition was
    /// registered.
    registered_at: ?i64 = null,

    /// The principal that registered the daemon task definition.
    registered_by: ?[]const u8 = null,

    /// The revision of the daemon task in a particular family. The revision is a
    /// version number of a daemon task definition in a family. When you register a
    /// daemon task definition for the first time, the revision is `1`. Each time
    /// that you register a new revision of a daemon task definition in the same
    /// family, the revision value always increases by one.
    revision: i32 = 0,

    /// The status of the daemon task definition. The valid values are `ACTIVE`,
    /// `DELETE_IN_PROGRESS`, and `DELETED`.
    status: ?DaemonTaskDefinitionStatus = null,

    /// The short name or full Amazon Resource Name (ARN) of the IAM role that
    /// grants containers in the daemon task permission to call Amazon Web Services
    /// APIs on your behalf.
    task_role_arn: ?[]const u8 = null,

    /// The list of data volume definitions for the daemon task.
    volumes: ?[]const DaemonVolume = null,

    pub const json_field_names = .{
        .container_definitions = "containerDefinitions",
        .cpu = "cpu",
        .daemon_task_definition_arn = "daemonTaskDefinitionArn",
        .delete_requested_at = "deleteRequestedAt",
        .execution_role_arn = "executionRoleArn",
        .family = "family",
        .ipc_mode = "ipcMode",
        .memory = "memory",
        .pid_mode = "pidMode",
        .registered_at = "registeredAt",
        .registered_by = "registeredBy",
        .revision = "revision",
        .status = "status",
        .task_role_arn = "taskRoleArn",
        .volumes = "volumes",
    };
};
