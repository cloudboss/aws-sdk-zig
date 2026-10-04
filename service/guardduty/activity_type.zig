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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
