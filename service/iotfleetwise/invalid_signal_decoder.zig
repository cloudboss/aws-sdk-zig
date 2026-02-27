const SignalDecoderFailureReason = @import("signal_decoder_failure_reason.zig").SignalDecoderFailureReason;

/// A reason that a signal decoder isn't valid.
pub const InvalidSignalDecoder = struct {
    /// The possible cause for the invalid signal decoder.
    hint: ?[]const u8,

    /// The name of a signal decoder that isn't valid.
    name: ?[]const u8,

    /// A message about why the signal decoder isn't valid.
    reason: ?SignalDecoderFailureReason,

    pub const json_field_names = .{
        .hint = "hint",
        .name = "name",
        .reason = "reason",
    };
};
