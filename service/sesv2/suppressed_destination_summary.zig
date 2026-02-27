const SuppressionListReason = @import("suppression_list_reason.zig").SuppressionListReason;

/// A summary that describes the suppressed email address.
pub const SuppressedDestinationSummary = struct {
    /// The email address that's on the suppression list for your account.
    email_address: []const u8,

    /// The date and time when the suppressed destination was last updated, shown in
    /// Unix time
    /// format.
    last_update_time: i64,

    /// The reason that the address was added to the suppression list for your
    /// account.
    reason: SuppressionListReason,

    pub const json_field_names = .{
        .email_address = "EmailAddress",
        .last_update_time = "LastUpdateTime",
        .reason = "Reason",
    };
};
