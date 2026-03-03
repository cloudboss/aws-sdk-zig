const std = @import("std");

/// The possible states of a channel alert. SET - The alert is actively
/// happening. CLEARED - The alert is no longer happening.
pub const ChannelAlertState = enum {
    set,
    cleared,

    pub const json_field_names = .{
        .set = "SET",
        .cleared = "CLEARED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .set => "SET",
            .cleared => "CLEARED",
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
