const Geometry = @import("geometry.zig").Geometry;
const TextTypes = @import("text_types.zig").TextTypes;

/// Information about a word or line of text detected by DetectText.
///
/// The `DetectedText` field contains the text that Amazon Rekognition detected
/// in the
/// image.
///
/// Every word and line has an identifier (`Id`). Each word belongs to a line
/// and has a parent identifier (`ParentId`) that identifies the line of text in
/// which
/// the word appears. The word `Id` is also an index for the word within a line
/// of
/// words.
///
/// For more information, see Detecting text in the Amazon Rekognition Developer
/// Guide.
pub const TextDetection = struct {
    /// The confidence that Amazon Rekognition has in the accuracy of the detected
    /// text and the accuracy
    /// of the geometry points around the detected text.
    confidence: ?f32,

    /// The word or line of text recognized by Amazon Rekognition.
    detected_text: ?[]const u8,

    /// The location of the detected text on the image. Includes an axis aligned
    /// coarse
    /// bounding box surrounding the text and a finer grain polygon for more
    /// accurate spatial
    /// information.
    geometry: ?Geometry,

    /// The identifier for the detected text. The identifier is only unique for a
    /// single call
    /// to `DetectText`.
    id: ?i32,

    /// The Parent identifier for the detected text identified by the value of `ID`.
    /// If the type of detected text is `LINE`, the value of `ParentId` is
    /// `Null`.
    parent_id: ?i32,

    /// The type of text that was detected.
    type: ?TextTypes,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .detected_text = "DetectedText",
        .geometry = "Geometry",
        .id = "Id",
        .parent_id = "ParentId",
        .type = "Type",
    };
};
