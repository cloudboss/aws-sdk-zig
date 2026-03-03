const aws = @import("aws");

const ModelVersion = @import("model_version.zig").ModelVersion;

/// The fraud prediction scores.
pub const ModelScores = struct {
    /// The model version.
    model_version: ?ModelVersion = null,

    /// The model's fraud prediction scores.
    scores: ?[]const aws.map.MapEntry(f32) = null,

    pub const json_field_names = .{
        .model_version = "modelVersion",
        .scores = "scores",
    };
};
