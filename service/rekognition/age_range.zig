/// Structure containing the estimated age range, in years, for a face.
///
/// Amazon Rekognition estimates an age range for faces detected in the input
/// image. Estimated age
/// ranges can overlap. A face of a 5-year-old might have an estimated range of
/// 4-6, while the
/// face of a 6-year-old might have an estimated range of 4-8.
pub const AgeRange = struct {
    /// The highest estimated age.
    high: ?i32 = null,

    /// The lowest estimated age.
    low: ?i32 = null,

    pub const json_field_names = .{
        .high = "High",
        .low = "Low",
    };
};
