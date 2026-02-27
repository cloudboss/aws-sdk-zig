const GroundTruthManifest = @import("ground_truth_manifest.zig").GroundTruthManifest;

/// Assets are the images that you use to train and evaluate a model version.
/// Assets can also contain validation information that you use to debug a
/// failed model training.
pub const Asset = struct {
    ground_truth_manifest: ?GroundTruthManifest,

    pub const json_field_names = .{
        .ground_truth_manifest = "GroundTruthManifest",
    };
};
