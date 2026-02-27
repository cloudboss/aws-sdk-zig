/// The section of the contact audio where that category rule was detected.
pub const PointOfInterest = struct {
    /// The beginning offset in milliseconds where the category rule was detected.
    begin_offset_millis: i32,

    /// The ending offset in milliseconds where the category rule was detected.
    end_offset_millis: i32,

    pub const json_field_names = .{
        .begin_offset_millis = "BeginOffsetMillis",
        .end_offset_millis = "EndOffsetMillis",
    };
};
