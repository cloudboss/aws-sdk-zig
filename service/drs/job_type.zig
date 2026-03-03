const std = @import("std");

pub const JobType = enum {
    launch,
    terminate,
    create_converted_snapshot,

    pub const json_field_names = .{
        .launch = "LAUNCH",
        .terminate = "TERMINATE",
        .create_converted_snapshot = "CREATE_CONVERTED_SNAPSHOT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .launch => "LAUNCH",
            .terminate => "TERMINATE",
            .create_converted_snapshot => "CREATE_CONVERTED_SNAPSHOT",
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
