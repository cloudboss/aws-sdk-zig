const std = @import("std");

pub const DirectoryType = enum {
    simple_ad,
    ad_connector,
    microsoft_ad,
    shared_microsoft_ad,

    pub const json_field_names = .{
        .simple_ad = "SimpleAD",
        .ad_connector = "ADConnector",
        .microsoft_ad = "MicrosoftAD",
        .shared_microsoft_ad = "SharedMicrosoftAD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .simple_ad => "SimpleAD",
            .ad_connector => "ADConnector",
            .microsoft_ad => "MicrosoftAD",
            .shared_microsoft_ad => "SharedMicrosoftAD",
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
