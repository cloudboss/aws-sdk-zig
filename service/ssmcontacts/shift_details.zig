/// Information about overrides to an on-call rotation shift.
pub const ShiftDetails = struct {
    /// The Amazon Resources Names (ARNs) of the contacts who were replaced in a
    /// shift when an
    /// override was created. If the override is deleted, these contacts are
    /// restored to the
    /// shift.
    overridden_contact_ids: []const []const u8,

    pub const json_field_names = .{
        .overridden_contact_ids = "OverriddenContactIds",
    };
};
