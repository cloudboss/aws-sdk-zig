pub const SegmentType = enum {
    classic,
    enhanced,

    pub const json_field_names = .{
        .classic = "CLASSIC",
        .enhanced = "ENHANCED",
    };
};
