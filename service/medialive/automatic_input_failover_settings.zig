const FailoverCondition = @import("failover_condition.zig").FailoverCondition;
const InputPreference = @import("input_preference.zig").InputPreference;

/// The settings for Automatic Input Failover.
pub const AutomaticInputFailoverSettings = struct {
    /// This clear time defines the requirement a recovered input must meet to be
    /// considered healthy. The input must have no failover conditions for this
    /// length of time. Enter a time in milliseconds. This value is particularly
    /// important if the input_preference for the failover pair is set to
    /// PRIMARY_INPUT_PREFERRED, because after this time, MediaLive will switch back
    /// to the primary input.
    error_clear_time_msec: ?i32,

    /// A list of failover conditions. If any of these conditions occur, MediaLive
    /// will perform a failover to the other input.
    failover_conditions: ?[]const FailoverCondition,

    /// Input preference when deciding which input to make active when a previously
    /// failed input has recovered.
    input_preference: ?InputPreference,

    /// The input ID of the secondary input in the automatic input failover pair.
    secondary_input_id: []const u8,

    pub const json_field_names = .{
        .error_clear_time_msec = "ErrorClearTimeMsec",
        .failover_conditions = "FailoverConditions",
        .input_preference = "InputPreference",
        .secondary_input_id = "SecondaryInputId",
    };
};
