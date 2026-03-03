const std = @import("std");

/// Specify the color space you want for this output. The service supports
/// conversion between HDR formats, between SDR formats, from SDR to HDR, and
/// from HDR to SDR. SDR to HDR conversion doesn't upgrade the dynamic range.
/// The converted video has an HDR format, but visually appears the same as an
/// unconverted output. HDR to SDR conversion uses tone mapping to approximate
/// the outcome of manually regrading from HDR to SDR. When you specify an
/// output color space, MediaConvert uses the following color space metadata,
/// which includes color primaries, transfer characteristics, and matrix
/// coefficients:
/// * HDR 10: BT.2020, PQ, BT.2020 non-constant
/// * HLG 2020: BT.2020, HLG, BT.2020 non-constant
/// * P3DCI (Theater): DCIP3, SMPTE 428M, BT.709
/// * P3D65 (SDR): Display P3, sRGB, BT.709
/// * P3D65 (HDR): Display P3, PQ, BT.709
pub const ColorSpaceConversion = enum {
    none,
    force_601,
    force_709,
    force_hdr10,
    force_hlg_2020,
    force_p3_dci,
    force_p3_d65_sdr,
    force_p3_d65_hdr,

    pub const json_field_names = .{
        .none = "NONE",
        .force_601 = "FORCE_601",
        .force_709 = "FORCE_709",
        .force_hdr10 = "FORCE_HDR10",
        .force_hlg_2020 = "FORCE_HLG_2020",
        .force_p3_dci = "FORCE_P3DCI",
        .force_p3_d65_sdr = "FORCE_P3D65_SDR",
        .force_p3_d65_hdr = "FORCE_P3D65_HDR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .force_601 => "FORCE_601",
            .force_709 => "FORCE_709",
            .force_hdr10 => "FORCE_HDR10",
            .force_hlg_2020 => "FORCE_HLG_2020",
            .force_p3_dci => "FORCE_P3DCI",
            .force_p3_d65_sdr => "FORCE_P3D65_SDR",
            .force_p3_d65_hdr => "FORCE_P3D65_HDR",
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
