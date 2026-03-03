const Computation = @import("computation.zig").Computation;
const CustomNarrativeOptions = @import("custom_narrative_options.zig").CustomNarrativeOptions;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;

/// The configuration of an insight visual.
pub const InsightConfiguration = struct {
    /// The computations configurations of the insight visual
    computations: ?[]const Computation = null,

    /// The custom narrative of the insight visual.
    custom_narrative: ?CustomNarrativeOptions = null,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions = null,

    pub const json_field_names = .{
        .computations = "Computations",
        .custom_narrative = "CustomNarrative",
        .interactions = "Interactions",
    };
};
