const std = @import("std");

pub const ManifestServicePublishOptInEventType = enum {
    pre_session_init_hook_summary,
    pre_session_init_function_completed,

    pub const json_field_names = .{
        .pre_session_init_hook_summary = "PRE_SESSION_INIT_HOOK_SUMMARY",
        .pre_session_init_function_completed = "PRE_SESSION_INIT_FUNCTION_COMPLETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pre_session_init_hook_summary => "PRE_SESSION_INIT_HOOK_SUMMARY",
            .pre_session_init_function_completed => "PRE_SESSION_INIT_FUNCTION_COMPLETED",
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
