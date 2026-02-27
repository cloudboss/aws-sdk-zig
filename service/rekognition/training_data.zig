const Asset = @import("asset.zig").Asset;

/// The dataset used for training.
pub const TrainingData = struct {
    /// A manifest file that contains references to the training images and
    /// ground-truth
    /// annotations.
    assets: ?[]const Asset,

    pub const json_field_names = .{
        .assets = "Assets",
    };
};
