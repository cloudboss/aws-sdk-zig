const RouteLeg = @import("route_leg.zig").RouteLeg;
const RouteMajorRoadLabel = @import("route_major_road_label.zig").RouteMajorRoadLabel;
const RouteSummary = @import("route_summary.zig").RouteSummary;

/// The route.
pub const Route = struct {
    /// A leg is a section of a route from one waypoint to the next. A leg could be
    /// of type Vehicle, Pedestrian or Ferry. Legs of different types could occur
    /// together within a single route. For example, a car employing the use of a
    /// Ferry will contain Vehicle legs corresponding to journey on land, and Ferry
    /// legs corresponding to the journey via Ferry.
    legs: []const RouteLeg,

    /// Important labels including names and route numbers that differentiate the
    /// current route from the alternatives presented.
    major_road_labels: []const RouteMajorRoadLabel,

    /// Summarized details of the leg.
    summary: ?RouteSummary,

    pub const json_field_names = .{
        .legs = "Legs",
        .major_road_labels = "MajorRoadLabels",
        .summary = "Summary",
    };
};
