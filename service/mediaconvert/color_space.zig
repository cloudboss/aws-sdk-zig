const std = @import("std");

/// If your input video has accurate color space metadata, or if you don't know
/// about color space: Keep the default value, Follow. MediaConvert will
/// automatically detect your input color space. If your input video has
/// metadata indicating the wrong color space, or has missing metadata: Specify
/// the accurate color space here. If your input video is HDR 10 and the SMPTE
/// ST 2086 Mastering Display Color Volume static metadata isn't present in your
/// video stream, or if that metadata is present but not accurate: Choose Force
/// HDR 10. Specify correct values in the input HDR 10 metadata settings. For
/// more information about HDR jobs, see
/// https://docs.aws.amazon.com/console/mediaconvert/hdr. When you specify an
/// input color space, MediaConvert uses the following color space metadata,
/// which includes color primaries, transfer characteristics, and matrix
/// coefficients:
/// * HDR 10: BT.2020, PQ, BT.2020 non-constant
/// * HLG 2020: BT.2020, HLG, BT.2020 non-constant
/// * P3DCI (Theater): DCIP3, SMPTE 428M, BT.709
/// * P3D65 (SDR): Display P3, sRGB, BT.709
/// * P3D65 (HDR): Display P3, PQ, BT.709
pub const ColorSpace = enum {
    follow,
    rec_601,
    rec_709,
    hdr10,
    hlg_2020,
    p3_dci,
    p3_d65_sdr,
    p3_d65_hdr,

    pub const json_field_names = .{
        .follow = "FOLLOW",
        .rec_601 = "REC_601",
        .rec_709 = "REC_709",
        .hdr10 = "HDR10",
        .hlg_2020 = "HLG_2020",
        .p3_dci = "P3DCI",
        .p3_d65_sdr = "P3D65_SDR",
        .p3_d65_hdr = "P3D65_HDR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .follow => "FOLLOW",
            .rec_601 => "REC_601",
            .rec_709 => "REC_709",
            .hdr10 => "HDR10",
            .hlg_2020 => "HLG_2020",
            .p3_dci => "P3DCI",
            .p3_d65_sdr => "P3D65_SDR",
            .p3_d65_hdr => "P3D65_HDR",
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
