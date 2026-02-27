/// The image source (image bytes) of the guardrail image source. Object used in
/// independent api.
pub const GuardrailImageSource = union(enum) {
    /// The bytes details of the guardrail image source. Object used in independent
    /// api.
    bytes: ?[]const u8,

    pub const json_field_names = .{
        .bytes = "bytes",
    };
};
