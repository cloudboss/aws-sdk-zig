/// Hls Incomplete Segment Behavior
pub const HlsIncompleteSegmentBehavior = enum {
    auto,
    suppress,

    pub const json_field_names = .{
        .auto = "AUTO",
        .suppress = "SUPPRESS",
    };
};
