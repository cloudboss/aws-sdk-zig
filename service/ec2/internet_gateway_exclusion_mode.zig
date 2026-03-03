const std = @import("std");

pub const InternetGatewayExclusionMode = enum {
    allow_bidirectional,
    allow_egress,

    pub const json_field_names = .{
        .allow_bidirectional = "allow-bidirectional",
        .allow_egress = "allow-egress",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .allow_bidirectional => "allow-bidirectional",
            .allow_egress => "allow-egress",
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
