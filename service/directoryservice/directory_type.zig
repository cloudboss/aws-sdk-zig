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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
