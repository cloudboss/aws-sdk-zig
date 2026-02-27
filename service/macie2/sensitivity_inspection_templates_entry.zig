/// Provides information about the sensitivity inspection template for an Amazon
/// Macie account.
pub const SensitivityInspectionTemplatesEntry = struct {
    /// The unique identifier for the sensitivity inspection template.
    id: ?[]const u8,

    /// The name of the sensitivity inspection template:
    /// automated-sensitive-data-discovery.
    name: ?[]const u8,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
    };
};
