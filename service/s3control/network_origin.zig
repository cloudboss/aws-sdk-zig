const std = @import("std");

pub const NetworkOrigin = enum {
    internet,
    vpc,

    pub const json_field_names = .{
        .internet = "Internet",
        .vpc = "VPC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .internet => "Internet",
            .vpc => "VPC",
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
