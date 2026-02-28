const FreeTrialStatus = @import("free_trial_status.zig").FreeTrialStatus;
const FreeTrialType = @import("free_trial_type.zig").FreeTrialType;

/// An object that contains information about the Amazon Inspector free trial
/// for an account.
pub const FreeTrialInfo = struct {
    /// The date and time that the Amazon Inspector free trail ends for a given
    /// account.
    end: i64,

    /// The date and time that the Amazon Inspector free trail started for a given
    /// account.
    start: i64,

    /// The order to sort results by.
    status: FreeTrialStatus,

    /// The type of scan covered by the Amazon Inspector free trail.
    @"type": FreeTrialType,

    pub const json_field_names = .{
        .end = "end",
        .start = "start",
        .status = "status",
        .@"type" = "type",
    };
};
