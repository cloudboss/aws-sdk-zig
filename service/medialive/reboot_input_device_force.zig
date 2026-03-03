const std = @import("std");

/// Whether or not to force reboot the input device.
pub const RebootInputDeviceForce = enum {
    no,
    yes,

    pub const json_field_names = .{
        .no = "NO",
        .yes = "YES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no => "NO",
            .yes => "YES",
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
