const aws = @import("aws");

/// Provides feature transformation information. Feature transformation is the
/// process
/// of modifying raw input data into a form more suitable for model training.
pub const FeatureTransformation = struct {
    /// The creation date and time (in Unix time) of the feature transformation.
    creation_date_time: ?i64 = null,

    /// Provides the default parameters for feature transformation.
    default_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the FeatureTransformation object.
    feature_transformation_arn: ?[]const u8 = null,

    /// The last update date and time (in Unix time) of the feature transformation.
    last_updated_date_time: ?i64 = null,

    /// The name of the feature transformation.
    name: ?[]const u8 = null,

    /// The status of the feature transformation.
    ///
    /// A feature transformation can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .default_parameters = "defaultParameters",
        .feature_transformation_arn = "featureTransformationArn",
        .last_updated_date_time = "lastUpdatedDateTime",
        .name = "name",
        .status = "status",
    };
};
