/// Object containing details about applications as defined in Application
/// Discovery Service.
pub const AssociatedApplication = struct {
    /// ID of the application as defined in Application Discovery Service.
    id: ?[]const u8 = null,

    /// Name of the application as defined in Application Discovery Service.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
    };
};
