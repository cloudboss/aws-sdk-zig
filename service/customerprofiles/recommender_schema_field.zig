const ContentType = @import("content_type.zig").ContentType;
const FeatureType = @import("feature_type.zig").FeatureType;

/// Defines a column in a recommender schema, including the target field name
/// and optional feature and content type settings for training.
pub const RecommenderSchemaField = struct {
    /// The data type of the column value. Valid values are `String` and `Number`.
    /// The default value is `String`.
    content_type: ?ContentType = null,

    /// How the column is treated for model training. Valid values are `CATEGORICAL`
    /// and `TEXTUAL`.
    feature_type: ?FeatureType = null,

    /// The name of the target field in the dataset, such as `Location.City` or
    /// `Attributes.MealTime`.
    target_field_name: []const u8,

    pub const json_field_names = .{
        .content_type = "ContentType",
        .feature_type = "FeatureType",
        .target_field_name = "TargetFieldName",
    };
};
