const std = @import("std");

pub const BehaviorType = enum {
    route_current_channel_only,
    route_any_channel,

    pub const json_field_names = .{
        .route_current_channel_only = "ROUTE_CURRENT_CHANNEL_ONLY",
        .route_any_channel = "ROUTE_ANY_CHANNEL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .route_current_channel_only => "ROUTE_CURRENT_CHANNEL_ONLY",
            .route_any_channel => "ROUTE_ANY_CHANNEL",
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
