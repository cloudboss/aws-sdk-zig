/// Text Caption Position Settings
pub const TextCaptionPositionSettings = struct {
    /// Specifies the vertical position of the top edge of the caption relative to
    /// the top of the output as a percentage. A value of 0 places the caption at
    /// the top of the output and 100 at the bottom.
    y_position_percentage: ?i32 = null,

    pub const json_field_names = .{
        .y_position_percentage = "YPositionPercentage",
    };
};
