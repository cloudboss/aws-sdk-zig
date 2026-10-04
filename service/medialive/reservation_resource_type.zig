const std = @import("std");

/// Resource type, 'INPUT', 'OUTPUT', 'MULTIPLEX', or 'CHANNEL'
pub const ReservationResourceType = enum {
    input,
    output,
    multiplex,
    channel,

    pub const json_field_names = .{
        .input = "INPUT",
        .output = "OUTPUT",
        .multiplex = "MULTIPLEX",
        .channel = "CHANNEL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .input => "INPUT",
            .output => "OUTPUT",
            .multiplex => "MULTIPLEX",
            .channel => "CHANNEL",
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
