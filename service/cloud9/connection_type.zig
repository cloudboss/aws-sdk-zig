const std = @import("std");

pub const ConnectionType = enum {
    connect_ssh,
    connect_ssm,

    pub const json_field_names = .{
        .connect_ssh = "CONNECT_SSH",
        .connect_ssm = "CONNECT_SSM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .connect_ssh => "CONNECT_SSH",
            .connect_ssm => "CONNECT_SSM",
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
