/// A link to documentation that provides additional information for a
/// recommendation.
pub const DocLink = struct {
    /// The text with the link to documentation for the recommendation.
    text: ?[]const u8,

    /// The URL for the documentation for the recommendation.
    url: ?[]const u8,
};
