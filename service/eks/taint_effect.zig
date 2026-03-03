const std = @import("std");

pub const TaintEffect = enum {
    no_schedule,
    no_execute,
    prefer_no_schedule,

    pub const json_field_names = .{
        .no_schedule = "NO_SCHEDULE",
        .no_execute = "NO_EXECUTE",
        .prefer_no_schedule = "PREFER_NO_SCHEDULE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_schedule => "NO_SCHEDULE",
            .no_execute => "NO_EXECUTE",
            .prefer_no_schedule => "PREFER_NO_SCHEDULE",
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
