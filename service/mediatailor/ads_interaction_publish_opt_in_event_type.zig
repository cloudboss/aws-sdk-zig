const std = @import("std");

pub const AdsInteractionPublishOptInEventType = enum {
    raw_ads_response,
    raw_ads_request,

    pub const json_field_names = .{
        .raw_ads_response = "RAW_ADS_RESPONSE",
        .raw_ads_request = "RAW_ADS_REQUEST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .raw_ads_response => "RAW_ADS_RESPONSE",
            .raw_ads_request => "RAW_ADS_REQUEST",
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
