const std = @import("std");

/// The color space matrix coefficients of the video track, defining how RGB
/// color values are converted to and from YUV color space. This affects color
/// accuracy during encoding and decoding processes.
pub const MatrixCoefficients = enum {
    rgb,
    itu_709,
    unspecified,
    reserved,
    fcc,
    itu_470_bg,
    smpte_170_m,
    smpte_240_m,
    y_cg_co,
    itu_2020_ncl,
    itu_2020_cl,
    smpte_2085,
    cd_ncl,
    cd_cl,
    itu_2100_i_ct_cp,
    ipt,
    ebu3213,
    last,

    pub const json_field_names = .{
        .rgb = "RGB",
        .itu_709 = "ITU_709",
        .unspecified = "UNSPECIFIED",
        .reserved = "RESERVED",
        .fcc = "FCC",
        .itu_470_bg = "ITU_470BG",
        .smpte_170_m = "SMPTE_170M",
        .smpte_240_m = "SMPTE_240M",
        .y_cg_co = "YCgCo",
        .itu_2020_ncl = "ITU_2020_NCL",
        .itu_2020_cl = "ITU_2020_CL",
        .smpte_2085 = "SMPTE_2085",
        .cd_ncl = "CD_NCL",
        .cd_cl = "CD_CL",
        .itu_2100_i_ct_cp = "ITU_2100ICtCp",
        .ipt = "IPT",
        .ebu3213 = "EBU3213",
        .last = "LAST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rgb => "RGB",
            .itu_709 => "ITU_709",
            .unspecified => "UNSPECIFIED",
            .reserved => "RESERVED",
            .fcc => "FCC",
            .itu_470_bg => "ITU_470BG",
            .smpte_170_m => "SMPTE_170M",
            .smpte_240_m => "SMPTE_240M",
            .y_cg_co => "YCgCo",
            .itu_2020_ncl => "ITU_2020_NCL",
            .itu_2020_cl => "ITU_2020_CL",
            .smpte_2085 => "SMPTE_2085",
            .cd_ncl => "CD_NCL",
            .cd_cl => "CD_CL",
            .itu_2100_i_ct_cp => "ITU_2100ICtCp",
            .ipt => "IPT",
            .ebu3213 => "EBU3213",
            .last => "LAST",
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
