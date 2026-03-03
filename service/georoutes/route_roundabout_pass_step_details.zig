const LocalizedString = @import("localized_string.zig").LocalizedString;
const RouteSteeringDirection = @import("route_steering_direction.zig").RouteSteeringDirection;
const RouteTurnIntensity = @import("route_turn_intensity.zig").RouteTurnIntensity;

/// Details about the step.
pub const RouteRoundaboutPassStepDetails = struct {
    /// Name of the intersection, if applicable to the step.
    intersection: []const LocalizedString,

    /// Steering direction for the step.
    steering_direction: ?RouteSteeringDirection = null,

    /// Angle of the turn.
    turn_angle: f64 = 0,

    /// Intensity of the turn.
    turn_intensity: ?RouteTurnIntensity = null,

    pub const json_field_names = .{
        .intersection = "Intersection",
        .steering_direction = "SteeringDirection",
        .turn_angle = "TurnAngle",
        .turn_intensity = "TurnIntensity",
    };
};
