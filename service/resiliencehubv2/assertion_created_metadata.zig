/// Metadata for an assertion created event.
pub const AssertionCreatedMetadata = struct {
    /// The unique identifier of the created assertion.
    assertion_id: ?[]const u8 = null,

    /// The name of the created assertion.
    assertion_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .assertion_id = "assertionId",
        .assertion_name = "assertionName",
    };
};
