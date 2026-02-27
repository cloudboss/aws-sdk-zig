const aws = @import("aws");

/// The Amazon SageMaker run configuration.
pub const SageMakerRunConfigurationInput = struct {
    /// The tracking assets of the Amazon SageMaker run.
    tracking_assets: []const aws.map.MapEntry([]const []const u8),

    pub const json_field_names = .{
        .tracking_assets = "trackingAssets",
    };
};
