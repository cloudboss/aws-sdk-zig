const std = @import("std");

/// Container for this output. Some containers require a container settings
/// object. If not specified, the default object will be created.
pub const ContainerType = enum {
    f4_v,
    gif,
    ismv,
    m2_ts,
    m3_u8,
    cmfc,
    mov,
    mp4,
    mpd,
    mxf,
    ogg,
    webm,
    raw,
    y4_m,

    pub const json_field_names = .{
        .f4_v = "F4V",
        .gif = "GIF",
        .ismv = "ISMV",
        .m2_ts = "M2TS",
        .m3_u8 = "M3U8",
        .cmfc = "CMFC",
        .mov = "MOV",
        .mp4 = "MP4",
        .mpd = "MPD",
        .mxf = "MXF",
        .ogg = "OGG",
        .webm = "WEBM",
        .raw = "RAW",
        .y4_m = "Y4M",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .f4_v => "F4V",
            .gif => "GIF",
            .ismv => "ISMV",
            .m2_ts => "M2TS",
            .m3_u8 => "M3U8",
            .cmfc => "CMFC",
            .mov => "MOV",
            .mp4 => "MP4",
            .mpd => "MPD",
            .mxf => "MXF",
            .ogg => "OGG",
            .webm => "WEBM",
            .raw => "RAW",
            .y4_m => "Y4M",
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
