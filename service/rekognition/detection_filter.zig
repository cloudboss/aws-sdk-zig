/// A set of parameters that allow you to filter out certain results from your
/// returned results.
pub const DetectionFilter = struct {
    /// Sets the minimum height of the word bounding box. Words with bounding box
    /// heights lesser than
    /// this value will be excluded from the result. Value is relative to the video
    /// frame height.
    min_bounding_box_height: ?f32,

    /// Sets the minimum width of the word bounding box. Words with bounding boxes
    /// widths lesser than
    /// this value will be excluded from the result. Value is relative to the video
    /// frame width.
    min_bounding_box_width: ?f32,

    /// Sets the confidence of word detection. Words with detection confidence below
    /// this will be
    /// excluded from the result. Values should be between 0 and 100. The default
    /// MinConfidence is
    /// 80.
    min_confidence: ?f32,

    pub const json_field_names = .{
        .min_bounding_box_height = "MinBoundingBoxHeight",
        .min_bounding_box_width = "MinBoundingBoxWidth",
        .min_confidence = "MinConfidence",
    };
};
