const std = @import("std");

pub const CommandFilterKey = enum {
    invoked_after,
    invoked_before,
    status,
    execution_stage,
    document_name,

    pub const json_field_names = .{
        .invoked_after = "InvokedAfter",
        .invoked_before = "InvokedBefore",
        .status = "Status",
        .execution_stage = "ExecutionStage",
        .document_name = "DocumentName",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invoked_after => "InvokedAfter",
            .invoked_before => "InvokedBefore",
            .status => "Status",
            .execution_stage => "ExecutionStage",
            .document_name => "DocumentName",
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
