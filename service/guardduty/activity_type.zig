const std = @import("std");

/// The type of an observed activity.
pub const ActivityType = enum {
    /// The observed activity is an API call.
    api_call,

    pub const json_field_names = .{
        .api_call = "API_CALL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .api_call => "API_CALL",
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
