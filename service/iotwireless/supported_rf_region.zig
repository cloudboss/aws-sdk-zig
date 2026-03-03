const std = @import("std");

/// Supported RfRegions
pub const SupportedRfRegion = enum {
    eu868,
    us915,
    au915,
    as923_1,
    as923_2,
    as923_3,
    as923_4,
    eu433,
    cn470,
    cn779,
    ru864,
    kr920,
    in865,

    pub const json_field_names = .{
        .eu868 = "EU868",
        .us915 = "US915",
        .au915 = "AU915",
        .as923_1 = "AS923-1",
        .as923_2 = "AS923-2",
        .as923_3 = "AS923-3",
        .as923_4 = "AS923-4",
        .eu433 = "EU433",
        .cn470 = "CN470",
        .cn779 = "CN779",
        .ru864 = "RU864",
        .kr920 = "KR920",
        .in865 = "IN865",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .eu868 => "EU868",
            .us915 => "US915",
            .au915 => "AU915",
            .as923_1 => "AS923-1",
            .as923_2 => "AS923-2",
            .as923_3 => "AS923-3",
            .as923_4 => "AS923-4",
            .eu433 => "EU433",
            .cn470 => "CN470",
            .cn779 => "CN779",
            .ru864 => "RU864",
            .kr920 => "KR920",
            .in865 => "IN865",
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
