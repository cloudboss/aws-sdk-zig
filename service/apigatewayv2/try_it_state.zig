/// Represents the try it state for a product REST endpoint page.
pub const TryItState = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
