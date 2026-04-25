/// A custom descriptor configuration for a registry record.
pub const CustomDescriptor = struct {
    /// The inline content of the custom descriptor.
    inline_content: ?[]const u8 = null,

    pub const json_field_names = .{
        .inline_content = "inlineContent",
    };
};
