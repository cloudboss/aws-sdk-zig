const std = @import("std");

/// Dash Role Caption
pub const DashRoleCaption = enum {
    alternate,
    caption,
    commentary,
    description,
    dub,
    easyreader,
    emergency,
    forced_subtitle,
    karaoke,
    main,
    metadata,
    subtitle,
    supplementary,

    pub const json_field_names = .{
        .alternate = "ALTERNATE",
        .caption = "CAPTION",
        .commentary = "COMMENTARY",
        .description = "DESCRIPTION",
        .dub = "DUB",
        .easyreader = "EASYREADER",
        .emergency = "EMERGENCY",
        .forced_subtitle = "FORCED-SUBTITLE",
        .karaoke = "KARAOKE",
        .main = "MAIN",
        .metadata = "METADATA",
        .subtitle = "SUBTITLE",
        .supplementary = "SUPPLEMENTARY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .alternate => "ALTERNATE",
            .caption => "CAPTION",
            .commentary => "COMMENTARY",
            .description => "DESCRIPTION",
            .dub => "DUB",
            .easyreader => "EASYREADER",
            .emergency => "EMERGENCY",
            .forced_subtitle => "FORCED-SUBTITLE",
            .karaoke => "KARAOKE",
            .main => "MAIN",
            .metadata => "METADATA",
            .subtitle => "SUBTITLE",
            .supplementary => "SUPPLEMENTARY",
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
