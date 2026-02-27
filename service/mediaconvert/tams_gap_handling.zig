/// Specify how MediaConvert handles gaps between media segments in your TAMS
/// source. Gaps can occur in live streams due to network issues or other
/// interruptions. Choose from the following options: * Skip gaps - Default.
/// Skip over gaps and join segments together. This creates a continuous output
/// with no blank frames, but may cause timeline discontinuities. * Fill with
/// black - Insert black frames to fill gaps between segments. This maintains
/// timeline continuity but adds black frames where content is missing. * Hold
/// last frame - Repeat the last frame before a gap until the next segment
/// begins. This maintains visual continuity during gaps.
pub const TamsGapHandling = enum {
    skip_gaps,
    fill_with_black,
    hold_last_frame,

    pub const json_field_names = .{
        .skip_gaps = "SKIP_GAPS",
        .fill_with_black = "FILL_WITH_BLACK",
        .hold_last_frame = "HOLD_LAST_FRAME",
    };
};
