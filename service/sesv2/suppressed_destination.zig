const SuppressedDestinationAttributes = @import("suppressed_destination_attributes.zig").SuppressedDestinationAttributes;
const SuppressionListReason = @import("suppression_list_reason.zig").SuppressionListReason;

/// An object that contains information about an email address that is on the
/// suppression
/// list for your account.
pub const SuppressedDestination = struct {
    /// An optional value that can contain additional information about the reasons
    /// that the
    /// address was added to the suppression list for your account.
    attributes: ?SuppressedDestinationAttributes = null,

    /// The email address that is on the suppression list for your account.
    email_address: []const u8,

    /// The date and time when the suppressed destination was last updated, shown in
    /// Unix time
    /// format.
    last_update_time: i64,

    /// The reason that the address was added to the suppression list for your
    /// account.
    reason: SuppressionListReason,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .email_address = "EmailAddress",
        .last_update_time = "LastUpdateTime",
        .reason = "Reason",
    };
};
