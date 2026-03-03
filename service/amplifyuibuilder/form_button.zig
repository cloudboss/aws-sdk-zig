const FieldPosition = @import("field_position.zig").FieldPosition;

/// Describes the configuration for a button UI element that is a part of a
/// form.
pub const FormButton = struct {
    /// Describes the button's properties.
    children: ?[]const u8 = null,

    /// Specifies whether the button is visible on the form.
    excluded: ?bool = null,

    /// The position of the button.
    position: ?FieldPosition = null,

    pub const json_field_names = .{
        .children = "children",
        .excluded = "excluded",
        .position = "position",
    };
};
