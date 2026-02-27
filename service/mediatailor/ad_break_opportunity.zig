/// A location at which a zero-duration ad marker was detected in a VOD source
/// manifest.
pub const AdBreakOpportunity = struct {
    /// The offset in milliseconds from the start of the VOD source at which an ad
    /// marker was detected.
    offset_millis: i64 = 0,

    pub const json_field_names = .{
        .offset_millis = "OffsetMillis",
    };
};
