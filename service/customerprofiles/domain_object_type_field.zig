const ContentType = @import("content_type.zig").ContentType;
const FeatureType = @import("feature_type.zig").FeatureType;

/// The standard domain object type.
pub const DomainObjectTypeField = struct {
    /// The content type of the field.
    content_type: ?ContentType,

    /// The semantic meaning of the field.
    feature_type: ?FeatureType,

    /// The expression that defines how to extract the field value from the source
    /// object.>
    source: []const u8,

    /// The expression that defines where the field value should be placed in the
    /// standard domain object.
    target: []const u8,

    pub const json_field_names = .{
        .content_type = "ContentType",
        .feature_type = "FeatureType",
        .source = "Source",
        .target = "Target",
    };
};
