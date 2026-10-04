const std = @import("std");

/// Specifies the rollback state while disabling Auto-Tune for the domain. Valid
/// values are NO_ROLLBACK, DEFAULT_ROLLBACK.
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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
