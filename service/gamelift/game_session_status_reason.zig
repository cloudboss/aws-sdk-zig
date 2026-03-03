const std = @import("std");

pub const GameSessionStatusReason = enum {
    interrupted,
    triggered_on_process_terminate,
    force_terminated,

    pub const json_field_names = .{
        .interrupted = "INTERRUPTED",
        .triggered_on_process_terminate = "TRIGGERED_ON_PROCESS_TERMINATE",
        .force_terminated = "FORCE_TERMINATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .interrupted => "INTERRUPTED",
            .triggered_on_process_terminate => "TRIGGERED_ON_PROCESS_TERMINATE",
            .force_terminated => "FORCE_TERMINATED",
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
