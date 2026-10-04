const std = @import("std");

pub const OutputLockingMode = enum {
    epoch_locked,
    non_epoch_locked,

    pub const json_field_names = .{
        .epoch_locked = "EPOCH_LOCKED",
        .non_epoch_locked = "NON_EPOCH_LOCKED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .epoch_locked => "EPOCH_LOCKED",
            .non_epoch_locked => "NON_EPOCH_LOCKED",
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
