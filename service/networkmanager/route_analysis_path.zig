const RouteAnalysisCompletion = @import("route_analysis_completion.zig").RouteAnalysisCompletion;
const PathComponent = @import("path_component.zig").PathComponent;

/// Describes a route analysis path.
pub const RouteAnalysisPath = struct {
    /// The status of the analysis at completion.
    completion_status: ?RouteAnalysisCompletion = null,

    /// The route analysis path.
    path: ?[]const PathComponent = null,

    pub const json_field_names = .{
        .completion_status = "CompletionStatus",
        .path = "Path",
    };
};
