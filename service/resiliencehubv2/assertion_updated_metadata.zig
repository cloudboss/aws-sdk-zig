/// Metadata for an assertion updated event.
pub const AssertionUpdatedMetadata = struct {
    /// The unique identifier of the updated assertion.
    assertion_id: ?[]const u8 = null,

    /// The name of the updated assertion.
    assertion_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .assertion_id = "assertionId",
        .assertion_name = "assertionName",
    };
};
