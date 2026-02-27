/// Object containing information about the model versions of selected features
/// in a given job.
pub const MediaAnalysisModelVersions = struct {
    /// The Moderation base model version.
    moderation: ?[]const u8,

    pub const json_field_names = .{
        .moderation = "Moderation",
    };
};
