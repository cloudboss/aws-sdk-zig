/// The value associated with a feature.
pub const FeatureValue = struct {
    /// The name of a feature that a feature value corresponds to.
    feature_name: []const u8,

    /// The value in string format associated with a feature. Used when your
    /// `CollectionType` is `None`. Note that features types can be
    /// `String`, `Integral`, or `Fractional`. This value
    /// represents all three types as a string.
    value_as_string: ?[]const u8 = null,

    /// The list of values in string format associated with a feature. Used when
    /// your
    /// `CollectionType` is a `List`, `Set`, or
    /// `Vector`. Note that features types can be `String`,
    /// `Integral`, or `Fractional`. These values represents all three
    /// types as a string.
    value_as_string_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .feature_name = "FeatureName",
        .value_as_string = "ValueAsString",
        .value_as_string_list = "ValueAsStringList",
    };
};
