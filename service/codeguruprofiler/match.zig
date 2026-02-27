/// The part of a profile that contains a recommendation found during analysis.
pub const Match = struct {
    /// The location in the profiling graph that contains a recommendation found
    /// during analysis.
    frame_address: ?[]const u8,

    /// The target frame that triggered a match.
    target_frames_index: ?i32,

    /// The value in the profile data that exceeded the recommendation threshold.
    threshold_breach_value: ?f64,

    pub const json_field_names = .{
        .frame_address = "frameAddress",
        .target_frames_index = "targetFramesIndex",
        .threshold_breach_value = "thresholdBreachValue",
    };
};
