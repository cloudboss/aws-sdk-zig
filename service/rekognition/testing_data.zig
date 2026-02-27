const Asset = @import("asset.zig").Asset;

/// The dataset used for testing. Optionally, if `AutoCreate` is set, Amazon
/// Rekognition uses the
/// training dataset to create a test dataset with a temporary split of the
/// training dataset.
pub const TestingData = struct {
    /// The assets used for testing.
    assets: ?[]const Asset,

    /// If specified, Rekognition splits training dataset to create a test dataset
    /// for
    /// the training job.
    auto_create: bool = false,

    pub const json_field_names = .{
        .assets = "Assets",
        .auto_create = "AutoCreate",
    };
};
