/// Information about the detector state.
pub const DetectorStateSummary = struct {
    /// The name of the state.
    state_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .state_name = "stateName",
    };
};
