const std = @import("std");

pub const VideoColorimetry = enum {
    bt709,
    bt470_m,
    bt470_bg,
    bt601,
    smpte240_m,
    generic_film,
    bt2020,
    smpte428,
    smpte431,
    smpte432,

    pub const json_field_names = .{
        .bt709 = "BT709",
        .bt470_m = "BT470M",
        .bt470_bg = "BT470BG",
        .bt601 = "BT601",
        .smpte240_m = "SMPTE240M",
        .generic_film = "GENERIC_FILM",
        .bt2020 = "BT2020",
        .smpte428 = "SMPTE428",
        .smpte431 = "SMPTE431",
        .smpte432 = "SMPTE432",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bt709 => "BT709",
            .bt470_m => "BT470M",
            .bt470_bg => "BT470BG",
            .bt601 => "BT601",
            .smpte240_m => "SMPTE240M",
            .generic_film => "GENERIC_FILM",
            .bt2020 => "BT2020",
            .smpte428 => "SMPTE428",
            .smpte431 => "SMPTE431",
            .smpte432 => "SMPTE432",
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
