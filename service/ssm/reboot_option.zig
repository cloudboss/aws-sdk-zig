const std = @import("std");

pub const RebootOption = enum {
    reboot_if_needed,
    no_reboot,

    pub const json_field_names = .{
        .reboot_if_needed = "RebootIfNeeded",
        .no_reboot = "NoReboot",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .reboot_if_needed => "RebootIfNeeded",
            .no_reboot => "NoReboot",
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
