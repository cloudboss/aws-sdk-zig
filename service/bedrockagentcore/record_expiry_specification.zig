const RecordExpiryAction = @import("record_expiry_action.zig").RecordExpiryAction;

/// Specifies the record expiry (long-term memory time-to-live) applied to the
/// records in a batch request. Provide exactly one of
/// `recordExpiryDurationDays` or `action`. Set `recordExpiryDurationDays` to
/// configure or update the expiry, or set `action` to `REMOVE` to remove a
/// previously configured expiry.
pub const RecordExpirySpecification = union(enum) {
    /// The action to apply to the existing record expiry configuration. Set to
    /// `REMOVE` to remove a previously configured expiry so that the records no
    /// longer expire. This value does not apply when creating records.
    action: ?RecordExpiryAction,
    /// The duration, in days, after which the records in this request expire. The
    /// minimum is 31 days.
    record_expiry_duration_days: ?i32,

    pub const json_field_names = .{
        .action = "action",
        .record_expiry_duration_days = "recordExpiryDurationDays",
    };
};
