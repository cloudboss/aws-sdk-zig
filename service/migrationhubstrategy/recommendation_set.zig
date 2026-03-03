const Strategy = @import("strategy.zig").Strategy;
const TargetDestination = @import("target_destination.zig").TargetDestination;
const TransformationTool = @import("transformation_tool.zig").TransformationTool;

/// Contains a recommendation set.
pub const RecommendationSet = struct {
    /// The recommended strategy.
    strategy: ?Strategy = null,

    /// The recommended target destination.
    target_destination: ?TargetDestination = null,

    /// The target destination for the recommendation set.
    transformation_tool: ?TransformationTool = null,

    pub const json_field_names = .{
        .strategy = "strategy",
        .target_destination = "targetDestination",
        .transformation_tool = "transformationTool",
    };
};
