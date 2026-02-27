const DatasetContentState = @import("dataset_content_state.zig").DatasetContentState;

/// The state of the dataset contents and the reason they are in this state.
pub const DatasetContentStatus = struct {
    /// The reason the dataset contents are in this state.
    reason: ?[]const u8,

    /// The state of the dataset contents. Can be one of READY, CREATING, SUCCEEDED,
    /// or
    /// FAILED.
    state: ?DatasetContentState,

    pub const json_field_names = .{
        .reason = "reason",
        .state = "state",
    };
};
