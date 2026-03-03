const aws = @import("aws");

/// The Amazon SageMaker run configuration.
pub const SageMakerRunConfigurationOutput = struct {
    /// The Amazon SageMaker account ID.
    account_id: ?[]const u8 = null,

    /// The Amazon SageMaker Region.
    region: ?[]const u8 = null,

    /// The tracking assets of the Amazon SageMaker.
    tracking_assets: []const aws.map.MapEntry([]const []const u8),

    pub const json_field_names = .{
        .account_id = "accountId",
        .region = "region",
        .tracking_assets = "trackingAssets",
    };
};
