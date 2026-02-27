const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const ResolveTo = @import("resolve_to.zig").ResolveTo;
const TargetResource = @import("target_resource.zig").TargetResource;

/// Contains the execution summary of the computation model.
pub const ExecutionSummary = struct {
    /// The type of action exectued.
    action_type: ?[]const u8,

    /// The time the process ended.
    execution_end_time: ?i64,

    /// The execution entity version associated with the summary.
    execution_entity_version: ?[]const u8,

    /// The ID of the execution.
    execution_id: []const u8,

    /// The time the process started.
    execution_start_time: i64,

    /// The status of the execution process.
    execution_status: ExecutionStatus,

    /// The detailed resource this execution resolves to.
    resolve_to: ?ResolveTo,

    target_resource: TargetResource,

    /// The version of the target resource.
    target_resource_version: []const u8,

    pub const json_field_names = .{
        .action_type = "actionType",
        .execution_end_time = "executionEndTime",
        .execution_entity_version = "executionEntityVersion",
        .execution_id = "executionId",
        .execution_start_time = "executionStartTime",
        .execution_status = "executionStatus",
        .resolve_to = "resolveTo",
        .target_resource = "targetResource",
        .target_resource_version = "targetResourceVersion",
    };
};
