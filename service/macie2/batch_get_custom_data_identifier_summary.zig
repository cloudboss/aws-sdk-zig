/// Provides information about a custom data identifier.
pub const BatchGetCustomDataIdentifierSummary = struct {
    /// The Amazon Resource Name (ARN) of the custom data identifier.
    arn: ?[]const u8,

    /// The date and time, in UTC and extended ISO 8601 format, when the custom data
    /// identifier was created.
    created_at: ?i64,

    /// Specifies whether the custom data identifier was deleted. If you delete a
    /// custom data identifier, Amazon Macie doesn't delete it permanently. Instead,
    /// it soft deletes the identifier.
    deleted: ?bool,

    /// The custom description of the custom data identifier.
    description: ?[]const u8,

    /// The unique identifier for the custom data identifier.
    id: ?[]const u8,

    /// The custom name of the custom data identifier.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .deleted = "deleted",
        .description = "description",
        .id = "id",
        .name = "name",
    };
};
