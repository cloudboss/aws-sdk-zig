const LocalizedString = @import("localized_string.zig").LocalizedString;

/// Details related to the continue step.
pub const RouteContinueStepDetails = struct {
    /// Name of the intersection, if applicable to the step.
    intersection: []const LocalizedString,

    pub const json_field_names = .{
        .intersection = "Intersection",
    };
};
