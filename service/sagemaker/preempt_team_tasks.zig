const std = @import("std");

pub const PreemptTeamTasks = enum {
    never,
    lowerpriority,

    pub const json_field_names = .{
        .never = "Never",
        .lowerpriority = "LowerPriority",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .never => "Never",
            .lowerpriority => "LowerPriority",
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
