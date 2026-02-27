const Strategy = @import("strategy.zig").Strategy;
const TargetDestination = @import("target_destination.zig").TargetDestination;
const TransformationToolName = @import("transformation_tool_name.zig").TransformationToolName;

/// Information about all the available strategy options for migrating and
/// modernizing an
/// application component.
pub const StrategyOption = struct {
    /// Indicates if a specific strategy is preferred for the application component.
    is_preferred: ?bool,

    /// Type of transformation. For example, Rehost, Replatform, and so on.
    strategy: ?Strategy,

    /// Destination information about where the application component can migrate
    /// to. For
    /// example, `EC2`, `ECS`, and so on.
    target_destination: ?TargetDestination,

    /// The name of the tool that can be used to transform an application component
    /// using this
    /// strategy.
    tool_name: ?TransformationToolName,

    pub const json_field_names = .{
        .is_preferred = "isPreferred",
        .strategy = "strategy",
        .target_destination = "targetDestination",
        .tool_name = "toolName",
    };
};
