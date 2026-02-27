const GradientStop = @import("gradient_stop.zig").GradientStop;

/// Determines the gradient color settings.
pub const GradientColor = struct {
    /// The list of gradient color stops.
    stops: ?[]const GradientStop,

    pub const json_field_names = .{
        .stops = "Stops",
    };
};
