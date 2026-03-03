/// A link to an Amazon Redshift Advisor reference for more information about a
/// recommendation.
pub const ReferenceLink = struct {
    /// The URL address to find more information.
    link: ?[]const u8 = null,

    /// The hyperlink text that describes the link to more information.
    text: ?[]const u8 = null,
};
