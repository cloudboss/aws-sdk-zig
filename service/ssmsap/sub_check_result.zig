/// Represents the result of a sub-check within a configuration check operation.
pub const SubCheckResult = struct {
    /// A description of what the sub-check validates.
    description: ?[]const u8 = null,

    /// The unique identifier of the sub-check result.
    id: ?[]const u8 = null,

    /// The name of the sub-check.
    name: ?[]const u8 = null,

    /// A list of references or documentation links related to the sub-check.
    references: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .references = "References",
    };
};
