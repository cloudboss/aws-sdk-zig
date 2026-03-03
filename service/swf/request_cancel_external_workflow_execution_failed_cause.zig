const std = @import("std");

pub const RequestCancelExternalWorkflowExecutionFailedCause = enum {
    unknown_external_workflow_execution,
    request_cancel_external_workflow_execution_rate_exceeded,
    operation_not_permitted,

    pub const json_field_names = .{
        .unknown_external_workflow_execution = "UNKNOWN_EXTERNAL_WORKFLOW_EXECUTION",
        .request_cancel_external_workflow_execution_rate_exceeded = "REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_RATE_EXCEEDED",
        .operation_not_permitted = "OPERATION_NOT_PERMITTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unknown_external_workflow_execution => "UNKNOWN_EXTERNAL_WORKFLOW_EXECUTION",
            .request_cancel_external_workflow_execution_rate_exceeded => "REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_RATE_EXCEEDED",
            .operation_not_permitted => "OPERATION_NOT_PERMITTED",
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
