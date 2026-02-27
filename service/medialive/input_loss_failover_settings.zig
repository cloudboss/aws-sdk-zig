/// MediaLive will perform a failover if content is not detected in this input
/// for the specified period.
pub const InputLossFailoverSettings = struct {
    /// The amount of time (in milliseconds) that no input is detected. After that
    /// time, an input failover will occur.
    input_loss_threshold_msec: ?i32,

    pub const json_field_names = .{
        .input_loss_threshold_msec = "InputLossThresholdMsec",
    };
};
