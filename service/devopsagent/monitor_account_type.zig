const std = @import("std");

/// AWS association type for monitoring account.
pub const MonitorAccountType = enum {
    monitor,

    pub const json_field_names = .{
        .monitor = "monitor",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .monitor => "monitor",
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
