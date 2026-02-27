/// A user-defined note added to a finding.
pub const Note = struct {
    /// The text of a note.
    ///
    /// Length Constraints: Minimum of 1. Maximum of 512.
    text: []const u8,

    /// A timestamp that indicates when the note was updated.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    updated_at: []const u8,

    /// The principal that created a note.
    updated_by: []const u8,

    pub const json_field_names = .{
        .text = "Text",
        .updated_at = "UpdatedAt",
        .updated_by = "UpdatedBy",
    };
};
