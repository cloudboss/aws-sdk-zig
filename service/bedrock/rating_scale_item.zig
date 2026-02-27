const RatingScaleItemValue = @import("rating_scale_item_value.zig").RatingScaleItemValue;

/// Defines the value and corresponding definition for one rating in a custom
/// metric rating scale.
pub const RatingScaleItem = struct {
    /// Defines the definition for one rating in a custom metric rating scale.
    definition: []const u8,

    /// Defines the value for one rating in a custom metric rating scale.
    value: RatingScaleItemValue,

    pub const json_field_names = .{
        .definition = "definition",
        .value = "value",
    };
};
