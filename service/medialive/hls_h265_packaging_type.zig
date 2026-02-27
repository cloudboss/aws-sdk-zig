/// Hls H265 Packaging Type
pub const HlsH265PackagingType = enum {
    hev1,
    hvc1,

    pub const json_field_names = .{
        .hev1 = "HEV1",
        .hvc1 = "HVC1",
    };
};
