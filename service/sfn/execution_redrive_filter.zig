const std = @import("std");

pub const ExecutionRedriveFilter = enum {
    redriven,
    not_redriven,

    pub const json_field_names = .{
        .redriven = "REDRIVEN",
        .not_redriven = "NOT_REDRIVEN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .redriven => "REDRIVEN",
            .not_redriven => "NOT_REDRIVEN",
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
