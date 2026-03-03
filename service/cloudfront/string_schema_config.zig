/// The configuration for a string schema.
pub const StringSchemaConfig = struct {
    /// A comment to describe the parameter.
    comment: ?[]const u8 = null,

    /// The default value of the parameter.
    default_value: ?[]const u8 = null,

    /// Whether the defined parameter is required.
    required: bool,
};
