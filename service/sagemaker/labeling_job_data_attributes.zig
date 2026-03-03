const ContentClassifier = @import("content_classifier.zig").ContentClassifier;

/// Attributes of the data specified by the customer. Use these to describe the
/// data to be labeled.
pub const LabelingJobDataAttributes = struct {
    /// Declares that your content is free of personally identifiable information or
    /// adult content. SageMaker may restrict the Amazon Mechanical Turk workers
    /// that can view your task based on this information.
    content_classifiers: ?[]const ContentClassifier = null,

    pub const json_field_names = .{
        .content_classifiers = "ContentClassifiers",
    };
};
