const std = @import("std");

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
        .document_name_prefix = "DocumentNamePrefix",
        .execution_status = "ExecutionStatus",
        .execution_id = "ExecutionId",
        .parent_execution_id = "ParentExecutionId",
        .current_action = "CurrentAction",
        .start_time_before = "StartTimeBefore",
        .start_time_after = "StartTimeAfter",
        .automation_type = "AutomationType",
        .tag_key = "TagKey",
        .target_resource_group = "TargetResourceGroup",
        .automation_subtype = "AutomationSubtype",
        .ops_item_id = "OpsItemId",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .document_name_prefix => "DocumentNamePrefix",
            .execution_status => "ExecutionStatus",
            .execution_id => "ExecutionId",
            .parent_execution_id => "ParentExecutionId",
            .current_action => "CurrentAction",
            .start_time_before => "StartTimeBefore",
            .start_time_after => "StartTimeAfter",
            .automation_type => "AutomationType",
            .tag_key => "TagKey",
            .target_resource_group => "TargetResourceGroup",
            .automation_subtype => "AutomationSubtype",
            .ops_item_id => "OpsItemId",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
