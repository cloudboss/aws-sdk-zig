/// Global navigation satellite system (GNSS) object used for positioning.
pub const Gnss = struct {
    /// Optional assistance altitude, which is the altitude of the device at capture
    /// time,
    /// specified in meters above the WGS84 reference ellipsoid.
    assist_altitude: ?f32,

    /// Optional assistance position information, specified using latitude and
    /// longitude
    /// values in degrees. The coordinates are inside the WGS84 reference frame.
    assist_position: ?[]const f32,

    /// Optional parameter that gives an estimate of the time when the GNSS scan
    /// information
    /// is taken, in seconds GPS time (GPST). If capture time is not specified, the
    /// local server
    /// time is used.
    capture_time: ?f32,

    /// Optional value that gives the capture time estimate accuracy, in seconds. If
    /// capture
    /// time accuracy is not specified, default value of 300 is used.
    capture_time_accuracy: ?f32,

    /// Payload that contains the GNSS scan result, or NAV message, in hexadecimal
    /// notation.
    payload: []const u8,

    /// Optional parameter that forces 2D solve, which modifies the positioning
    /// algorithm to a
    /// 2D solution problem. When this parameter is specified, the assistance
    /// altitude should
    /// have an accuracy of at least 10 meters.
    use_2_d_solver: bool = false,

    pub const json_field_names = .{
        .assist_altitude = "AssistAltitude",
        .assist_position = "AssistPosition",
        .capture_time = "CaptureTime",
        .capture_time_accuracy = "CaptureTimeAccuracy",
        .payload = "Payload",
        .use_2_d_solver = "Use2DSolver",
    };
};
