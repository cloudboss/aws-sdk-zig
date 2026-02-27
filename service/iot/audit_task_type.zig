pub const AuditTaskType = enum {
    on_demand_audit_task,
    scheduled_audit_task,

    pub const json_field_names = .{
        .on_demand_audit_task = "ON_DEMAND_AUDIT_TASK",
        .scheduled_audit_task = "SCHEDULED_AUDIT_TASK",
    };
};
