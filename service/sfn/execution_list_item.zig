const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;

/// Contains details about an execution.
pub const ExecutionListItem = struct {
    /// The Amazon Resource Name (ARN) that identifies the execution.
    execution_arn: []const u8,

    /// The total number of items processed in a child workflow execution. This
    /// field is returned only if `mapRunArn` was specified in the `ListExecutions`
    /// API action. If `stateMachineArn` was specified in `ListExecutions`, the
    /// `itemCount` field isn't returned.
    item_count: ?i32,

    /// The Amazon Resource Name (ARN) of a Map Run. This field is returned only if
    /// `mapRunArn` was specified in the `ListExecutions` API action. If
    /// `stateMachineArn` was specified in `ListExecutions`, the `mapRunArn` isn't
    /// returned.
    map_run_arn: ?[]const u8,

    /// The name of the execution.
    ///
    /// A name must *not* contain:
    ///
    /// * white space
    ///
    /// * brackets ` { } [ ]`
    ///
    /// * wildcard characters `? *`
    ///
    /// * special characters `" # % \ ^ | ~ ` $ & , ; : /`
    ///
    /// * control characters (`U+0000-001F`, `U+007F-009F`, `U+FFFE-FFFF`)
    ///
    /// * surrogates (`U+D800-DFFF`)
    ///
    /// * invalid characters (` U+10FFFF`)
    ///
    /// To enable logging with CloudWatch Logs, the name should only contain 0-9,
    /// A-Z, a-z, - and _.
    name: []const u8,

    /// The number of times you've redriven an execution. If you have not yet
    /// redriven an execution, the `redriveCount` is 0. This count is only updated
    /// when you successfully redrive an execution.
    redrive_count: ?i32,

    /// The date the execution was last redriven.
    redrive_date: ?i64,

    /// The date the execution started.
    start_date: i64,

    /// The Amazon Resource Name (ARN) of the state machine alias used to start an
    /// execution.
    ///
    /// If the state machine execution was started with an unqualified ARN or a
    /// version ARN, it returns null.
    state_machine_alias_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the state machine that ran the execution.
    state_machine_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the state machine version associated with
    /// the execution.
    ///
    /// If the state machine execution was started with an unqualified ARN, it
    /// returns null.
    ///
    /// If the execution was started using a `stateMachineAliasArn`, both the
    /// `stateMachineAliasArn` and `stateMachineVersionArn` parameters contain the
    /// respective values.
    state_machine_version_arn: ?[]const u8,

    /// The current status of the execution.
    status: ExecutionStatus,

    /// If the execution already ended, the date the execution stopped.
    stop_date: ?i64,

    pub const json_field_names = .{
        .execution_arn = "executionArn",
        .item_count = "itemCount",
        .map_run_arn = "mapRunArn",
        .name = "name",
        .redrive_count = "redriveCount",
        .redrive_date = "redriveDate",
        .start_date = "startDate",
        .state_machine_alias_arn = "stateMachineAliasArn",
        .state_machine_arn = "stateMachineArn",
        .state_machine_version_arn = "stateMachineVersionArn",
        .status = "status",
        .stop_date = "stopDate",
    };
};
