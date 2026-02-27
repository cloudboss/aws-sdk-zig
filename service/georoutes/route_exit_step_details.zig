const LocalizedString = @import("localized_string.zig").LocalizedString;
const RouteSteeringDirection = @import("route_steering_direction.zig").RouteSteeringDirection;
const RouteTurnIntensity = @import("route_turn_intensity.zig").RouteTurnIntensity;

/// Details related to the exit step.
pub const RouteExitStepDetails = struct {
    /// Name of the intersection, if applicable to the step.
    intersection: []const LocalizedString,

    /// Exit to be taken.
    relative_exit: ?i32,

    /// Steering direction for the step.
    steering_direction: ?RouteSteeringDirection,

    /// Angle of the turn.
    turn_angle: f64 = 0,

    /// Intensity of the turn.
    turn_intensity: ?RouteTurnIntensity,

    pub const json_field_names = .{
        .intersection = "Intersection",
        .relative_exit = "RelativeExit",
        .steering_direction = "SteeringDirection",
        .turn_angle = "TurnAngle",
        .turn_intensity = "TurnIntensity",
    };
};
