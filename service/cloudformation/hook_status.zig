const std = @import("std");

pub const HookStatus = enum {
    hook_in_progress,
    hook_complete_succeeded,
    hook_complete_failed,
    hook_failed,

    pub const json_field_names = .{
        .hook_in_progress = "HOOK_IN_PROGRESS",
        .hook_complete_succeeded = "HOOK_COMPLETE_SUCCEEDED",
        .hook_complete_failed = "HOOK_COMPLETE_FAILED",
        .hook_failed = "HOOK_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hook_in_progress => "HOOK_IN_PROGRESS",
            .hook_complete_succeeded => "HOOK_COMPLETE_SUCCEEDED",
            .hook_complete_failed => "HOOK_COMPLETE_FAILED",
            .hook_failed => "HOOK_FAILED",
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
