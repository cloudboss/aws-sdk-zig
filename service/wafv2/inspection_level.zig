pub const InspectionLevel = enum {
    common,
    targeted,

    pub const json_field_names = .{
        .common = "COMMON",
        .targeted = "TARGETED",
    };
};
