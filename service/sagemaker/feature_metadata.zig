const FeatureType = @import("feature_type.zig").FeatureType;
const FeatureParameter = @import("feature_parameter.zig").FeatureParameter;

/// The metadata for a feature. It can either be metadata that you specify, or
/// metadata that is updated automatically.
pub const FeatureMetadata = struct {
    /// A timestamp indicating when the feature was created.
    creation_time: ?i64 = null,

    /// An optional description that you specify to better describe the feature.
    description: ?[]const u8 = null,

    /// The Amazon Resource Number (ARN) of the feature group.
    feature_group_arn: ?[]const u8 = null,

    /// The name of the feature group containing the feature.
    feature_group_name: ?[]const u8 = null,

    /// The name of feature.
    feature_name: ?[]const u8 = null,

    /// The data type of the feature.
    feature_type: ?FeatureType = null,

    /// A timestamp indicating when the feature was last modified.
    last_modified_time: ?i64 = null,

    /// Optional key-value pairs that you specify to better describe the feature.
    parameters: ?[]const FeatureParameter = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .description = "Description",
        .feature_group_arn = "FeatureGroupArn",
        .feature_group_name = "FeatureGroupName",
        .feature_name = "FeatureName",
        .feature_type = "FeatureType",
        .last_modified_time = "LastModifiedTime",
        .parameters = "Parameters",
    };
};
