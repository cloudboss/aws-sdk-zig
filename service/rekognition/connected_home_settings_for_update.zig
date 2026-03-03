/// The label detection settings you want to use in your stream processor. This
/// includes the labels you want the stream processor to detect and the minimum
/// confidence level allowed to label objects.
pub const ConnectedHomeSettingsForUpdate = struct {
    /// Specifies what you want to detect in the video, such as people, packages, or
    /// pets. The current valid labels you can include in this list are: "PERSON",
    /// "PET", "PACKAGE", and "ALL".
    labels: ?[]const []const u8 = null,

    /// The minimum confidence required to label an object in the video.
    min_confidence: ?f32 = null,

    pub const json_field_names = .{
        .labels = "Labels",
        .min_confidence = "MinConfidence",
    };
};
