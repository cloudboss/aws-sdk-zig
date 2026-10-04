/// Contains the Meta application metadata associated with a WhatsApp Flow.
pub const MetaFlowApplicationInfo = struct {
    /// The unique identifier of the Meta application.
    id: []const u8,

    /// The URL link for the Meta application.
    link: ?[]const u8 = null,

    /// The name of the Meta application.
    name: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .link = "link",
        .name = "name",
    };
};
