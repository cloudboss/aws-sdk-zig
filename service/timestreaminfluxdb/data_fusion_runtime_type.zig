const std = @import("std");

pub const DataFusionRuntimeType = enum {
    multi_thread,
    multi_thread_alt,

    pub const json_field_names = .{
        .multi_thread = "multi-thread",
        .multi_thread_alt = "multi-thread-alt",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .multi_thread => "multi-thread",
            .multi_thread_alt => "multi-thread-alt",
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
