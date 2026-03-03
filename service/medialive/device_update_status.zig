const std = @import("std");

/// The status of software on the input device.
pub const DeviceUpdateStatus = enum {
    up_to_date,
    not_up_to_date,
    updating,

    pub const json_field_names = .{
        .up_to_date = "UP_TO_DATE",
        .not_up_to_date = "NOT_UP_TO_DATE",
        .updating = "UPDATING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .up_to_date => "UP_TO_DATE",
            .not_up_to_date => "NOT_UP_TO_DATE",
            .updating => "UPDATING",
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
