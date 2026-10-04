const std = @import("std");

pub const FailureHandlingPolicy = enum {
    rollback_on_failure,
    do_nothing,

    pub const json_field_names = .{
        .rollback_on_failure = "ROLLBACK_ON_FAILURE",
        .do_nothing = "DO_NOTHING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rollback_on_failure => "ROLLBACK_ON_FAILURE",
            .do_nothing => "DO_NOTHING",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
