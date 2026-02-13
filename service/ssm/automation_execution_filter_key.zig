pub const AutomationExecutionFilterKey = enum {
    document_name_prefix,
    execution_status,
    execution_id,
    parent_execution_id,
    current_action,
    start_time_before,
    start_time_after,
    automation_type,
    tag_key,
    target_resource_group,
    automation_subtype,
    ops_item_id,

    pub const json_field_names = .{
        .document_name_prefix = "DOCUMENT_NAME_PREFIX",
        .execution_status = "EXECUTION_STATUS",
        .execution_id = "EXECUTION_ID",
        .parent_execution_id = "PARENT_EXECUTION_ID",
        .current_action = "CURRENT_ACTION",
        .start_time_before = "START_TIME_BEFORE",
        .start_time_after = "START_TIME_AFTER",
        .automation_type = "AUTOMATION_TYPE",
        .tag_key = "TAG_KEY",
        .target_resource_group = "TARGET_RESOURCE_GROUP",
        .automation_subtype = "AUTOMATION_SUBTYPE",
        .ops_item_id = "OPS_ITEM_ID",
    };
};
