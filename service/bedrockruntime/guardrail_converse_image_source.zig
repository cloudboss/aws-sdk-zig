/// The image source (image bytes) of the guardrail converse image source.
pub const GuardrailConverseImageSource = union(enum) {
    /// The raw image bytes for the image.
    bytes: ?[]const u8,

    pub const json_field_names = .{
        .bytes = "bytes",
    };
};
