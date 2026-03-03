const std = @import("std");

/// Represents a connection type.
pub const ConnectionType = enum {
    internet,
    vpc_link,

    pub const json_field_names = .{
        .internet = "INTERNET",
        .vpc_link = "VPC_LINK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .internet => "INTERNET",
            .vpc_link => "VPC_LINK",
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
