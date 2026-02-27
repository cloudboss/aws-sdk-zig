const FixedPosition = @import("fixed_position.zig").FixedPosition;

/// Describes the field position.
pub const FieldPosition = union(enum) {
    /// The field position is below the field specified by the string.
    below: ?[]const u8,
    /// The field position is fixed and doesn't change in relation to other fields.
    fixed: ?FixedPosition,
    /// The field position is to the right of the field specified by the string.
    right_of: ?[]const u8,

    pub const json_field_names = .{
        .below = "below",
        .fixed = "fixed",
        .right_of = "rightOf",
    };
};
