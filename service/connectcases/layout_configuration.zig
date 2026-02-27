/// Object to store configuration of layouts associated to the template.
pub const LayoutConfiguration = struct {
    /// Unique identifier of a layout.
    default_layout: ?[]const u8,

    pub const json_field_names = .{
        .default_layout = "defaultLayout",
    };
};
