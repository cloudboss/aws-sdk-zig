pub const AssociationExecutionFilterKey = enum {
    execution_id,
    status,
    created_time,

    pub const json_field_names = .{
        .execution_id = "ExecutionId",
        .status = "Status",
        .created_time = "CreatedTime",
    };
};
