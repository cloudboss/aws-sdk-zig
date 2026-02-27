/// The configuration for a custom label on a `ReferenceLine`.
pub const ReferenceLineCustomLabelConfiguration = struct {
    /// The string text of the custom label.
    custom_label: []const u8,

    pub const json_field_names = .{
        .custom_label = "CustomLabel",
    };
};
