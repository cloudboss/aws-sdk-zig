const std = @import("std");

/// The rollback state while disabling Auto-Tune for the domain.
pub const RollbackOnDisable = enum {
    no_rollback,
    default_rollback,

    pub const json_field_names = .{
        .no_rollback = "NO_ROLLBACK",
        .default_rollback = "DEFAULT_ROLLBACK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_rollback => "NO_ROLLBACK",
            .default_rollback => "DEFAULT_ROLLBACK",
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
