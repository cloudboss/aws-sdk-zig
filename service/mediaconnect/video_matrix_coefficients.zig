const std = @import("std");

pub const VideoMatrixCoefficients = enum {
    identity,
    bt709,
    fcc,
    bt470_bg,
    bt601,
    smpte240_m,
    ycgco,
    bt2020_ncl,
    bt2020_cl,
    smpte2085,
    chromaticity_derived_ncl,
    chromaticity_derived_cl,
    bt2100_ictcp,
    ipt_c2,

    pub const json_field_names = .{
        .identity = "IDENTITY",
        .bt709 = "BT709",
        .fcc = "FCC",
        .bt470_bg = "BT470BG",
        .bt601 = "BT601",
        .smpte240_m = "SMPTE240M",
        .ycgco = "YCGCO",
        .bt2020_ncl = "BT2020_NCL",
        .bt2020_cl = "BT2020_CL",
        .smpte2085 = "SMPTE2085",
        .chromaticity_derived_ncl = "CHROMATICITY_DERIVED_NCL",
        .chromaticity_derived_cl = "CHROMATICITY_DERIVED_CL",
        .bt2100_ictcp = "BT2100_ICTCP",
        .ipt_c2 = "IPT_C2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .identity => "IDENTITY",
            .bt709 => "BT709",
            .fcc => "FCC",
            .bt470_bg => "BT470BG",
            .bt601 => "BT601",
            .smpte240_m => "SMPTE240M",
            .ycgco => "YCGCO",
            .bt2020_ncl => "BT2020_NCL",
            .bt2020_cl => "BT2020_CL",
            .smpte2085 => "SMPTE2085",
            .chromaticity_derived_ncl => "CHROMATICITY_DERIVED_NCL",
            .chromaticity_derived_cl => "CHROMATICITY_DERIVED_CL",
            .bt2100_ictcp => "BT2100_ICTCP",
            .ipt_c2 => "IPT_C2",
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
