const std = @import("std");

pub const StandbyInstances = enum {
    terminate,
    ignore,
    wait,

    pub const json_field_names = .{
        .terminate = "Terminate",
        .ignore = "Ignore",
        .wait = "Wait",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .terminate => "Terminate",
            .ignore => "Ignore",
            .wait => "Wait",
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
