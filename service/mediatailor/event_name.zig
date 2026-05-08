const std = @import("std");

pub const EventName = enum {
    pre_session_initialization,
    pre_ads_request,

    pub const json_field_names = .{
        .pre_session_initialization = "PRE_SESSION_INITIALIZATION",
        .pre_ads_request = "PRE_ADS_REQUEST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pre_session_initialization => "PRE_SESSION_INITIALIZATION",
            .pre_ads_request => "PRE_ADS_REQUEST",
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
