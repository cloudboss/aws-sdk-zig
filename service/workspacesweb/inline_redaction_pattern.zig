const CustomPattern = @import("custom_pattern.zig").CustomPattern;
const RedactionPlaceHolder = @import("redaction_place_holder.zig").RedactionPlaceHolder;

/// The set of patterns that determine the data types redacted in session.
pub const InlineRedactionPattern = struct {
    /// The built-in pattern from the list of preconfigured patterns. Either a
    /// customPattern or builtInPatternId is required.
    built_in_pattern_id: ?[]const u8,

    /// The confidence level for inline redaction pattern. This indicates the
    /// certainty of data type matches in the redaction process. Confidence level 3
    /// means high confidence, and requires a formatted text pattern match in order
    /// for content to be redacted. Confidence level 2 means medium confidence, and
    /// redaction considers both formatted and unformatted text, and adds keyword
    /// associate to the logic. Confidence level 1 means low confidence, and
    /// redaction is enforced for both formatted pattern + unformatted pattern
    /// without keyword. This overrides the global confidence level.
    confidence_level: ?i32,

    /// >The configuration for a custom pattern. Either a customPattern or
    /// builtInPatternId is required.
    custom_pattern: ?CustomPattern,

    /// The enforced URL configuration for the inline redaction pattern. This will
    /// override the global enforced URL configuration.
    enforced_urls: ?[]const []const u8,

    /// The exempt URL configuration for the inline redaction pattern. This will
    /// override the global exempt URL configuration for the inline redaction
    /// pattern.
    exempt_urls: ?[]const []const u8,

    /// The redaction placeholder that will replace the redacted text in session for
    /// the inline redaction pattern.
    redaction_place_holder: RedactionPlaceHolder,

    pub const json_field_names = .{
        .built_in_pattern_id = "builtInPatternId",
        .confidence_level = "confidenceLevel",
        .custom_pattern = "customPattern",
        .enforced_urls = "enforcedUrls",
        .exempt_urls = "exemptUrls",
        .redaction_place_holder = "redactionPlaceHolder",
    };
};
