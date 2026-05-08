/// A configuration bundle reference in a recommendation result.
pub const RecommendationResultConfigurationBundle = struct {
    /// The Amazon Resource Name (ARN) of the configuration bundle.
    bundle_arn: []const u8,

    /// The version identifier of the configuration bundle containing the
    /// recommendation.
    version_id: []const u8,

    pub const json_field_names = .{
        .bundle_arn = "bundleArn",
        .version_id = "versionId",
    };
};
