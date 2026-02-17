/// A summary of the call execution that includes an execution ID, the type of
/// execution (for
/// example, `Command`), and the date/time of the execution using a datetime
/// object that
/// is saved in the following format: `yyyy-MM-dd'T'HH:mm:ss'Z'`
pub const ComplianceExecutionSummary = struct {
    /// An ID created by the system when `PutComplianceItems` was called. For
    /// example,
    /// `CommandID` is a valid execution ID. You can use this ID in subsequent
    /// calls.
    execution_id: ?[]const u8,

    /// The time the execution ran as a datetime object that is saved in the
    /// following format:
    /// `yyyy-MM-dd'T'HH:mm:ss'Z'`
    ///
    /// For State Manager associations, this timestamp represents when the
    /// compliance status was
    /// captured and reported by the Systems Manager service, not when the
    /// underlying association was actually
    /// executed on the managed node. To track actual association execution times,
    /// use the DescribeAssociationExecutionTargets command or check the association
    /// execution
    /// history in the Systems Manager console.
    execution_time: i64,

    /// The type of execution. For example, `Command` is a valid execution type.
    execution_type: ?[]const u8,

    pub const json_field_names = .{
        .execution_id = "ExecutionId",
        .execution_time = "ExecutionTime",
        .execution_type = "ExecutionType",
    };
};
