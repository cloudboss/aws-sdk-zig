const std = @import("std");

pub const IngressPointType = enum {
    open,
    auth,
    mtls,

    pub const json_field_names = .{
        .open = "OPEN",
        .auth = "AUTH",
        .mtls = "MTLS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .open => "OPEN",
            .auth => "AUTH",
            .mtls => "MTLS",
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
