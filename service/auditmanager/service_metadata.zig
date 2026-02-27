/// The metadata that's associated with the Amazon Web Services service.
pub const ServiceMetadata = struct {
    /// The category that the Amazon Web Services service belongs to, such as
    /// compute, storage,
    /// or database.
    category: ?[]const u8,

    /// The description of the Amazon Web Services service.
    description: ?[]const u8,

    /// The display name of the Amazon Web Services service.
    display_name: ?[]const u8,

    /// The name of the Amazon Web Services service.
    name: ?[]const u8,

    pub const json_field_names = .{
        .category = "category",
        .description = "description",
        .display_name = "displayName",
        .name = "name",
    };
};
