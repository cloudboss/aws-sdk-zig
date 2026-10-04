/// Embedded Caption Position Settings
pub const EmbeddedCaptionPositionSettings = struct {
    /// Specifies the vertical position of the caption as a row counted from the top
    /// of the output. Row 1 is the topmost row. Acceptable values are 1 through 15.
    y_position_line: ?i32 = null,

    pub const json_field_names = .{
        .y_position_line = "YPositionLine",
    };
};
