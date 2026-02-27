/// Ms Smooth H265 Packaging Type
pub const MsSmoothH265PackagingType = enum {
    hev1,
    hvc1,

    pub const json_field_names = .{
        .hev1 = "HEV1",
        .hvc1 = "HVC1",
    };
};
