const std = @import("std");

pub const TargetRole = enum {
    read_write,
    read_only,
    unknown,

    pub const json_field_names = .{
        .read_write = "READ_WRITE",
        .read_only = "READ_ONLY",
        .unknown = "UNKNOWN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .read_write => "READ_WRITE",
            .read_only => "READ_ONLY",
            .unknown => "UNKNOWN",
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
