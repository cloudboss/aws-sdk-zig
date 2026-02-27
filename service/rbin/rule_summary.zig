const LockState = @import("lock_state.zig").LockState;
const RetentionPeriod = @import("retention_period.zig").RetentionPeriod;

/// Information about a Recycle Bin retention rule.
pub const RuleSummary = struct {
    /// The retention rule description.
    description: ?[]const u8,

    /// The unique ID of the retention rule.
    identifier: ?[]const u8,

    /// [Region-level retention rules only] The lock state for the retention rule.
    ///
    /// * `locked` - The retention rule is locked and can't be modified or deleted.
    ///
    /// * `pending_unlock` - The retention rule has been unlocked but it is still
    ///   within
    /// the unlock delay period. The retention rule can be modified or deleted only
    /// after the unlock
    /// delay period has expired.
    ///
    /// * `unlocked` - The retention rule is unlocked and it can be modified or
    ///   deleted by
    /// any user with the required permissions.
    ///
    /// * `null` - The retention rule has never been locked. Once a retention rule
    ///   has
    /// been locked, it can transition between the `locked` and `unlocked` states
    /// only; it can never transition back to `null`.
    lock_state: ?LockState,

    /// Information about the retention period for which the retention rule is to
    /// retain resources.
    retention_period: ?RetentionPeriod,

    /// The Amazon Resource Name (ARN) of the retention rule.
    rule_arn: ?[]const u8,

    pub const json_field_names = .{
        .description = "Description",
        .identifier = "Identifier",
        .lock_state = "LockState",
        .retention_period = "RetentionPeriod",
        .rule_arn = "RuleArn",
    };
};
