const ReferenceLinePatternType = @import("reference_line_pattern_type.zig").ReferenceLinePatternType;

/// The style configuration of the reference
/// line.
pub const ReferenceLineStyleConfiguration = struct {
    /// The hex color of the reference line.
    color: ?[]const u8,

    /// The pattern type of the line style. Choose one of the following options:
    ///
    /// * `SOLID`
    ///
    /// * `DASHED`
    ///
    /// * `DOTTED`
    pattern: ?ReferenceLinePatternType,

    pub const json_field_names = .{
        .color = "Color",
        .pattern = "Pattern",
    };
};
