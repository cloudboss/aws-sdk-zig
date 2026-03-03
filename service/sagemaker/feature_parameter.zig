/// A key-value pair that you specify to describe the feature.
pub const FeatureParameter = struct {
    /// A key that must contain a value to describe the feature.
    key: ?[]const u8 = null,

    /// The value that belongs to a key.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
