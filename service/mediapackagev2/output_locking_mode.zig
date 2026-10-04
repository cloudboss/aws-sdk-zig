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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
