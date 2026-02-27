/// Use Source to identify the format of your input captions. The service cannot
/// auto-detect caption format.
pub const CaptionSourceType = enum {
    ancillary,
    dvb_sub,
    embedded,
    scte20,
    scc,
    ttml,
    stl,
    srt,
    smi,
    smpte_tt,
    teletext,
    null_source,
    imsc,
    webvtt,
    tt_3_gpp,

    pub const json_field_names = .{
        .ancillary = "ANCILLARY",
        .dvb_sub = "DVB_SUB",
        .embedded = "EMBEDDED",
        .scte20 = "SCTE20",
        .scc = "SCC",
        .ttml = "TTML",
        .stl = "STL",
        .srt = "SRT",
        .smi = "SMI",
        .smpte_tt = "SMPTE_TT",
        .teletext = "TELETEXT",
        .null_source = "NULL_SOURCE",
        .imsc = "IMSC",
        .webvtt = "WEBVTT",
        .tt_3_gpp = "TT_3GPP",
    };
};
