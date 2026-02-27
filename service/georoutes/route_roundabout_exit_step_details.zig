const LocalizedString = @import("localized_string.zig").LocalizedString;
const RouteSteeringDirection = @import("route_steering_direction.zig").RouteSteeringDirection;

/// Details about the roundabout step.
pub const RouteRoundaboutExitStepDetails = struct {
    /// Name of the intersection, if applicable to the step.
    intersection: []const LocalizedString,

    /// Exit to be taken.
    relative_exit: ?i32,

    /// Angle of the roundabout.
    roundabout_angle: f64 = 0,

    /// Steering direction for the step.
    steering_direction: ?RouteSteeringDirection,

    pub const json_field_names = .{
        .intersection = "Intersection",
        .relative_exit = "RelativeExit",
        .roundabout_angle = "RoundaboutAngle",
        .steering_direction = "SteeringDirection",
    };
};
