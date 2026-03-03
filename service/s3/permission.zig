const std = @import("std");

pub const Permission = enum {
    full_control,
    write,
    write_acp,
    read,
    read_acp,

    pub const json_field_names = .{
        .full_control = "FULL_CONTROL",
        .write = "WRITE",
        .write_acp = "WRITE_ACP",
        .read = "READ",
        .read_acp = "READ_ACP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .full_control => "FULL_CONTROL",
            .write => "WRITE",
            .write_acp => "WRITE_ACP",
            .read => "READ",
            .read_acp => "READ_ACP",
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
