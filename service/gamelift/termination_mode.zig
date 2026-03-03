const std = @import("std");

pub const TerminationMode = enum {
    trigger_on_process_terminate,
    force_terminate,

    pub const json_field_names = .{
        .trigger_on_process_terminate = "TRIGGER_ON_PROCESS_TERMINATE",
        .force_terminate = "FORCE_TERMINATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .trigger_on_process_terminate => "TRIGGER_ON_PROCESS_TERMINATE",
            .force_terminate => "FORCE_TERMINATE",
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
