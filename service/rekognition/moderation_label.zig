/// Provides information about a single type of inappropriate, unwanted, or
/// offensive content found in an image or video. Each type of moderated content
/// has a label
/// within a hierarchical taxonomy. For more information, see Content moderation
/// in the Amazon Rekognition
/// Developer Guide.
pub const ModerationLabel = struct {
    /// Specifies the confidence that Amazon Rekognition has that the label has been
    /// correctly
    /// identified.
    ///
    /// If you don't specify the `MinConfidence` parameter in the call to
    /// `DetectModerationLabels`, the operation returns labels with a confidence
    /// value
    /// greater than or equal to 50 percent.
    confidence: ?f32,

    /// The label name for the type of unsafe content detected in the image.
    name: ?[]const u8,

    /// The name for the parent label. Labels at the top level of the hierarchy have
    /// the parent
    /// label `""`.
    parent_name: ?[]const u8,

    /// The level of the moderation label with regard to its taxonomy, from 1 to 3.
    taxonomy_level: ?i32,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .name = "Name",
        .parent_name = "ParentName",
        .taxonomy_level = "TaxonomyLevel",
    };
};
