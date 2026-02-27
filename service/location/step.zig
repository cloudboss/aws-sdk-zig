/// Represents an element of a leg within a route. A step contains instructions
/// for how to move to the next step in the leg.
pub const Step = struct {
    /// The travel distance between the step's `StartPosition` and `EndPosition`.
    distance: f64,

    /// The estimated travel time, in seconds, from the step's `StartPosition` to
    /// the `EndPosition`. . The travel mode and departure time that you specify in
    /// the request determines the calculated time.
    duration_seconds: f64,

    /// The end position of a step. If the position the last step in the leg, this
    /// position is the same as the end position of the leg.
    end_position: []const f64,

    /// Represents the start position, or index, in a sequence of steps within the
    /// leg's line string geometry. For example, the index of the first step in a
    /// leg geometry is `0`.
    ///
    /// Included in the response for queries that set `IncludeLegGeometry` to
    /// `True`.
    geometry_offset: ?i32,

    /// The starting position of a step. If the position is the first step in the
    /// leg, this position is the same as the start position of the leg.
    start_position: []const f64,

    pub const json_field_names = .{
        .distance = "Distance",
        .duration_seconds = "DurationSeconds",
        .end_position = "EndPosition",
        .geometry_offset = "GeometryOffset",
        .start_position = "StartPosition",
    };
};
