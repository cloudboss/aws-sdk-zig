/// Details about a wait operation that succeeded.
pub const WaitSucceededDetails = struct {
    /// The wait duration, in seconds.
    duration: ?i32,

    pub const json_field_names = .{
        .duration = "Duration",
    };
};
