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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
