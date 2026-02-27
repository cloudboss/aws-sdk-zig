/// Contains an asset attribute property. For more information, see
/// [Attributes](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/asset-properties.html#attributes) in the *IoT SiteWise User Guide*.
pub const Attribute = struct {
    /// The default value of the asset model property attribute. All assets that you
    /// create from
    /// the asset model contain this attribute value. You can update an attribute's
    /// value after you
    /// create an asset. For more information, see [Updating attribute
    /// values](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/update-attribute-values.html) in the
    /// *IoT SiteWise User Guide*.
    default_value: ?[]const u8,

    pub const json_field_names = .{
        .default_value = "defaultValue",
    };
};
