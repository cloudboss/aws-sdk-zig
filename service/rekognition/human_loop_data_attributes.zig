const ContentClassifier = @import("content_classifier.zig").ContentClassifier;

/// Allows you to set attributes of the image. Currently, you can declare an
/// image as free of
/// personally identifiable information.
pub const HumanLoopDataAttributes = struct {
    /// Sets whether the input image is free of personally identifiable information.
    content_classifiers: ?[]const ContentClassifier = null,

    pub const json_field_names = .{
        .content_classifiers = "ContentClassifiers",
    };
};
