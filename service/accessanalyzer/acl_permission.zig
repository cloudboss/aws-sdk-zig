const std = @import("std");

pub const AclPermission = enum {
    read,
    write,
    read_acp,
    write_acp,
    full_control,

    pub const json_field_names = .{
        .read = "READ",
        .write = "WRITE",
        .read_acp = "READ_ACP",
        .write_acp = "WRITE_ACP",
        .full_control = "FULL_CONTROL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .read => "READ",
            .write => "WRITE",
            .read_acp => "READ_ACP",
            .write_acp => "WRITE_ACP",
            .full_control => "FULL_CONTROL",
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
