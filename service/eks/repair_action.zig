const std = @import("std");

pub const RepairAction = enum {
    replace,
    reboot,
    no_action,

    pub const json_field_names = .{
        .replace = "Replace",
        .reboot = "Reboot",
        .no_action = "NoAction",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .replace => "Replace",
            .reboot => "Reboot",
            .no_action => "NoAction",
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
