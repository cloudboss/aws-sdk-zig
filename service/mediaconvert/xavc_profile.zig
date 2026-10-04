const std = @import("std");

/// Specify the XAVC profile for this output. For more information, see the Sony
/// documentation at https://www.xavc-info.org/. Note that when you choose
/// XAVC_HD_INTRA_CBG, MediaConvert supports interlaced outputs only when they
/// are top field first and your output frame rate is 25 or 29.97 fps.
pub const XavcProfile = enum {
    xavc_hd_intra_cbg,
    xavc_4_k_intra_cbg,
    xavc_4_k_intra_vbr,
    xavc_hd,
    xavc_4_k,

    pub const json_field_names = .{
        .xavc_hd_intra_cbg = "XAVC_HD_INTRA_CBG",
        .xavc_4_k_intra_cbg = "XAVC_4K_INTRA_CBG",
        .xavc_4_k_intra_vbr = "XAVC_4K_INTRA_VBR",
        .xavc_hd = "XAVC_HD",
        .xavc_4_k = "XAVC_4K",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .xavc_hd_intra_cbg => "XAVC_HD_INTRA_CBG",
            .xavc_4_k_intra_cbg => "XAVC_4K_INTRA_CBG",
            .xavc_4_k_intra_vbr => "XAVC_4K_INTRA_VBR",
            .xavc_hd => "XAVC_HD",
            .xavc_4_k => "XAVC_4K",
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
