const std = @import("std");

pub const DeploymentFailureHandlingPolicy = enum {
    rollback,
    do_nothing,

    pub const json_field_names = .{
        .rollback = "ROLLBACK",
        .do_nothing = "DO_NOTHING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rollback => "ROLLBACK",
            .do_nothing => "DO_NOTHING",
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
