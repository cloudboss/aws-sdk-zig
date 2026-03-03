const std = @import("std");

pub const EventType = enum {
    stack_event,
    progress_event,
    validation_error,
    provisioning_error,
    hook_invocation_error,

    pub const json_field_names = .{
        .stack_event = "STACK_EVENT",
        .progress_event = "PROGRESS_EVENT",
        .validation_error = "VALIDATION_ERROR",
        .provisioning_error = "PROVISIONING_ERROR",
        .hook_invocation_error = "HOOK_INVOCATION_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .stack_event => "STACK_EVENT",
            .progress_event => "PROGRESS_EVENT",
            .validation_error => "VALIDATION_ERROR",
            .provisioning_error => "PROVISIONING_ERROR",
            .hook_invocation_error => "HOOK_INVOCATION_ERROR",
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
