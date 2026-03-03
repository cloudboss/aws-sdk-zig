const std = @import("std");

/// Specify the QuickTime audio channel layout tags for the audio channels in
/// this audio track. Enter channel layout tags in the same order as your
/// output's audio channel order. For example, if your output audio track has a
/// left and a right channel, enter Left (L) for the first channel and Right (R)
/// for the second. If your output has multiple single-channel audio tracks,
/// enter a single channel layout tag for each track.
pub const AudioChannelTag = enum {
    l,
    r,
    c,
    lfe,
    ls,
    rs,
    lc,
    rc,
    cs,
    lsd,
    rsd,
    tcs,
    vhl,
    vhc,
    vhr,
    tbl,
    tbc,
    tbr,
    rsl,
    rsr,
    lw,
    rw,
    lfe2,
    lt,
    rt,
    hi,
    nar,
    m,

    pub const json_field_names = .{
        .l = "L",
        .r = "R",
        .c = "C",
        .lfe = "LFE",
        .ls = "LS",
        .rs = "RS",
        .lc = "LC",
        .rc = "RC",
        .cs = "CS",
        .lsd = "LSD",
        .rsd = "RSD",
        .tcs = "TCS",
        .vhl = "VHL",
        .vhc = "VHC",
        .vhr = "VHR",
        .tbl = "TBL",
        .tbc = "TBC",
        .tbr = "TBR",
        .rsl = "RSL",
        .rsr = "RSR",
        .lw = "LW",
        .rw = "RW",
        .lfe2 = "LFE2",
        .lt = "LT",
        .rt = "RT",
        .hi = "HI",
        .nar = "NAR",
        .m = "M",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .l => "L",
            .r => "R",
            .c => "C",
            .lfe => "LFE",
            .ls => "LS",
            .rs => "RS",
            .lc => "LC",
            .rc => "RC",
            .cs => "CS",
            .lsd => "LSD",
            .rsd => "RSD",
            .tcs => "TCS",
            .vhl => "VHL",
            .vhc => "VHC",
            .vhr => "VHR",
            .tbl => "TBL",
            .tbc => "TBC",
            .tbr => "TBR",
            .rsl => "RSL",
            .rsr => "RSR",
            .lw => "LW",
            .rw => "RW",
            .lfe2 => "LFE2",
            .lt => "LT",
            .rt => "RT",
            .hi => "HI",
            .nar => "NAR",
            .m => "M",
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
