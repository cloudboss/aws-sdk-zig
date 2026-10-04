const std = @import("std");

/// H265 Rate Control Mode
pub const H265RateControlMode = enum {
    cbr,
    multiplex,
    qvbr,

    pub const json_field_names = .{
        .cbr = "CBR",
        .multiplex = "MULTIPLEX",
        .qvbr = "QVBR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cbr => "CBR",
            .multiplex => "MULTIPLEX",
            .qvbr => "QVBR",
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
