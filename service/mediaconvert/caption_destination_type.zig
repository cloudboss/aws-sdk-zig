const std = @import("std");

/// Specify the format for this set of captions on this output. The default
/// format is embedded without SCTE-20. Note that your choice of video output
/// container constrains your choice of output captions format. For more
/// information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/captions-support-tables.html. If you are using SCTE-20 and you want to create an output that complies with the SCTE-43 spec, choose SCTE-20 plus embedded. To create a non-compliant output where the embedded captions come first, choose Embedded plus SCTE-20.
pub const CaptionDestinationType = enum {
    burn_in,
    dvb_sub,
    embedded,
    embedded_plus_scte20,
    imsc,
    scte20_plus_embedded,
    scc,
    srt,
    smi,
    teletext,
    ttml,
    webvtt,

    pub const json_field_names = .{
        .burn_in = "BURN_IN",
        .dvb_sub = "DVB_SUB",
        .embedded = "EMBEDDED",
        .embedded_plus_scte20 = "EMBEDDED_PLUS_SCTE20",
        .imsc = "IMSC",
        .scte20_plus_embedded = "SCTE20_PLUS_EMBEDDED",
        .scc = "SCC",
        .srt = "SRT",
        .smi = "SMI",
        .teletext = "TELETEXT",
        .ttml = "TTML",
        .webvtt = "WEBVTT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .burn_in => "BURN_IN",
            .dvb_sub => "DVB_SUB",
            .embedded => "EMBEDDED",
            .embedded_plus_scte20 => "EMBEDDED_PLUS_SCTE20",
            .imsc => "IMSC",
            .scte20_plus_embedded => "SCTE20_PLUS_EMBEDDED",
            .scc => "SCC",
            .srt => "SRT",
            .smi => "SMI",
            .teletext => "TELETEXT",
            .ttml => "TTML",
            .webvtt => "WEBVTT",
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
