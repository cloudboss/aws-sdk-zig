/// Contains information regarding the confidence and name of a detected content
/// type.
pub const ContentType = struct {
    /// The confidence level of the label given
    confidence: ?f32 = null,

    /// The name of the label
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .name = "Name",
    };
};
