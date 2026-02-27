/// Information about a policy attribute type.
pub const PolicyAttributeTypeDescription = struct {
    /// The name of the attribute.
    attribute_name: ?[]const u8,

    /// The type of the attribute. For example, `Boolean` or `Integer`.
    attribute_type: ?[]const u8,

    /// The cardinality of the attribute.
    ///
    /// Valid values:
    ///
    /// * ONE(1) : Single value required
    ///
    /// * ZERO_OR_ONE(0..1) : Up to one value is allowed
    ///
    /// * ZERO_OR_MORE(0..*) : Optional. Multiple values are allowed
    ///
    /// * ONE_OR_MORE(1..*0) : Required. Multiple values are allowed
    cardinality: ?[]const u8,

    /// The default value of the attribute, if applicable.
    default_value: ?[]const u8,

    /// A description of the attribute.
    description: ?[]const u8,
};
