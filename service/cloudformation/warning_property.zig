/// A specific property that is impacted by a warning.
pub const WarningProperty = struct {
    /// The description of the property from the resource provider schema.
    description: ?[]const u8,

    /// The path of the property. For example, if this is for the `S3Bucket` member
    /// of
    /// the `Code` property, the property path would be `Code/S3Bucket`.
    property_path: ?[]const u8,

    /// If `true`, the specified property is required.
    required: ?bool,
};
