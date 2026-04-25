/// An array of objects that provides details about a change to a finding,
/// including the
/// Amazon Web Services Security Finding Format (ASFF) field that changed, the
/// value of
/// the field before the change, and the value of the field after the change.
pub const FindingHistoryUpdate = struct {
    /// The value of the ASFF field after the finding change event. To preserve
    /// storage and readability, Security Hub CSPM omits this value
    /// if [
    /// `FindingHistoryRecord`
    /// ](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_FindingHistoryRecord.html) exceeds database limits.
    new_value: ?[]const u8 = null,

    /// The value of the ASFF field before the finding change event.
    old_value: ?[]const u8 = null,

    /// The ASFF field that changed during the finding change event.
    updated_field: ?[]const u8 = null,

    pub const json_field_names = .{
        .new_value = "NewValue",
        .old_value = "OldValue",
        .updated_field = "UpdatedField",
    };
};
