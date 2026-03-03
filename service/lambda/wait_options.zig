/// Specifies how long to pause the durable execution.
pub const WaitOptions = struct {
    /// The duration to wait, in seconds.
    wait_seconds: ?i32 = null,

    pub const json_field_names = .{
        .wait_seconds = "WaitSeconds",
    };
};
