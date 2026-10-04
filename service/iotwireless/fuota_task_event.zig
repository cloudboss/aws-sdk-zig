const std = @import("std");

/// The event for a log message, if the log message is tied to a FUOTA task.
pub const FuotaTaskEvent = enum {
    fuota,

    pub const json_field_names = .{
        .fuota = "Fuota",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fuota => "Fuota",
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
