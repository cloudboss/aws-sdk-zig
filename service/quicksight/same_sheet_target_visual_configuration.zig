const TargetVisualOptions = @import("target_visual_options.zig").TargetVisualOptions;

/// The configuration of the same-sheet target visuals that you want to be
/// filtered.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const SameSheetTargetVisualConfiguration = struct {
    /// The options that choose the target visual in the same sheet.
    ///
    /// Valid values are defined as follows:
    ///
    /// * `ALL_VISUALS`: Applies the filter operation to all visuals in the same
    ///   sheet.
    target_visual_options: ?TargetVisualOptions,

    /// A list of the target visual IDs that are located in the same sheet of the
    /// analysis.
    target_visuals: ?[]const []const u8,

    pub const json_field_names = .{
        .target_visual_options = "TargetVisualOptions",
        .target_visuals = "TargetVisuals",
    };
};
