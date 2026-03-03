const std = @import("std");

pub const PermissionType = enum {
    full_access,
    send_as,
    send_on_behalf,

    pub const json_field_names = .{
        .full_access = "FULL_ACCESS",
        .send_as = "SEND_AS",
        .send_on_behalf = "SEND_ON_BEHALF",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .full_access => "FULL_ACCESS",
            .send_as => "SEND_AS",
            .send_on_behalf => "SEND_ON_BEHALF",
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
