const GnssCapture = @import("gnss_capture.zig").GnssCapture;

/// Global navigation satellite system (GNSS) multi-frame object used for
/// positioning.
/// Contains multiple GNSS scan captures that are combined by the solver.
pub const GnssMultiFrame = struct {
    /// Optional assistance altitude, which is the altitude of the device at capture
    /// time,
    /// specified in meters above the WGS84 reference ellipsoid. This parameter is
    /// required
    /// when Use2DSolver is enabled.
    assist_altitude: ?f32 = null,

    /// Optional assistance position information, specified using latitude and
    /// longitude
    /// values in degrees. The coordinates are inside the WGS84 reference frame.
    assist_position: ?[]const f32 = null,

    /// List of GNSS scan captures. Each capture contains a payload from a single
    /// GNSS scan.
    /// The number of captures must be 2, 4, 8, 16, or 32.
    captures: []const GnssCapture,

    /// Optional value that gives the capture time estimate accuracy, in seconds. If
    /// capture
    /// time accuracy is not specified, default value of 300 is used.
    capture_time_accuracy: ?f32 = null,

    /// Optional parameter that forces 2D solve, which modifies the positioning
    /// algorithm to a
    /// 2D solution problem. When this parameter is specified, the assistance
    /// altitude should
    /// have an accuracy of at least 10 meters.
    use_2_d_solver: bool = false,

    pub const json_field_names = .{
        .assist_altitude = "AssistAltitude",
        .assist_position = "AssistPosition",
        .captures = "Captures",
        .capture_time_accuracy = "CaptureTimeAccuracy",
        .use_2_d_solver = "Use2DSolver",
    };
};
