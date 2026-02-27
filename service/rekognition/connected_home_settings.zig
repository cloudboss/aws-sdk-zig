/// Label detection settings to use on a streaming video. Defining the settings
/// is required in the request parameter for CreateStreamProcessor.
/// Including this setting in the `CreateStreamProcessor` request enables you to
/// use the stream processor for label detection.
/// You can then select what you want the stream processor to detect, such as
/// people or pets. When the stream processor has started, one notification
/// is sent for each object class specified. For example, if packages and pets
/// are selected, one SNS notification is published the first time a package is
/// detected
/// and one SNS notification is published the first time a pet is detected, as
/// well as an end-of-session summary.
pub const ConnectedHomeSettings = struct {
    /// Specifies what you want to detect in the video, such as people, packages, or
    /// pets. The current valid labels you can include in this list are: "PERSON",
    /// "PET", "PACKAGE", and "ALL".
    labels: []const []const u8,

    /// The minimum confidence required to label an object in the video.
    min_confidence: ?f32,

    pub const json_field_names = .{
        .labels = "Labels",
        .min_confidence = "MinConfidence",
    };
};
