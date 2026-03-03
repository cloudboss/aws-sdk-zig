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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
