const FontWeightName = @import("font_weight_name.zig").FontWeightName;

/// The option that determines the text display weight, or boldness.
pub const FontWeight = struct {
    /// The lexical name for the level of boldness of the text display.
    name: ?FontWeightName,

    pub const json_field_names = .{
        .name = "Name",
    };
};
