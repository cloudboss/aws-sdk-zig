/// Metadata for an assertion deleted event.
pub const AssertionDeletedMetadata = struct {
    /// The unique identifier of the deleted assertion.
    assertion_id: ?[]const u8 = null,

    /// The name of the deleted assertion.
    assertion_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .assertion_id = "assertionId",
        .assertion_name = "assertionName",
    };
};
