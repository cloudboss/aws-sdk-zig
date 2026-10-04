const std = @import("std");

pub const EventCode = enum {
    instance_reboot,
    system_reboot,
    system_maintenance,
    instance_retirement,
    instance_stop,

    pub const json_field_names = .{
        .instance_reboot = "instance-reboot",
        .system_reboot = "system-reboot",
        .system_maintenance = "system-maintenance",
        .instance_retirement = "instance-retirement",
        .instance_stop = "instance-stop",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .instance_reboot => "instance-reboot",
            .system_reboot => "system-reboot",
            .system_maintenance => "system-maintenance",
            .instance_retirement => "instance-retirement",
            .instance_stop => "instance-stop",
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
