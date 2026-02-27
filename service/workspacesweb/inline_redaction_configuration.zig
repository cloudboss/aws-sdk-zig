const InlineRedactionPattern = @import("inline_redaction_pattern.zig").InlineRedactionPattern;

/// The configuration for in-session inline redaction.
pub const InlineRedactionConfiguration = struct {
    /// The global confidence level for the inline redaction configuration. This
    /// indicates the certainty of data type matches in the redaction process.
    /// Confidence level 3 means high confidence, and requires a formatted text
    /// pattern match in order for content to be redacted. Confidence level 2 means
    /// medium confidence, and redaction considers both formatted and unformatted
    /// text, and adds keyword associate to the logic. Confidence level 1 means low
    /// confidence, and redaction is enforced for both formatted pattern +
    /// unformatted pattern without keyword. This is applied to patterns that do not
    /// have a pattern-level confidence level. Defaults to confidence level 2.
    global_confidence_level: ?i32,

    /// The global enforced URL configuration for the inline redaction
    /// configuration. This is applied to patterns that do not have a pattern-level
    /// enforced URL list.
    global_enforced_urls: ?[]const []const u8,

    /// The global exempt URL configuration for the inline redaction configuration.
    /// This is applied to patterns that do not have a pattern-level exempt URL
    /// list.
    global_exempt_urls: ?[]const []const u8,

    /// The inline redaction patterns to be enabled for the inline redaction
    /// configuration.
    inline_redaction_patterns: []const InlineRedactionPattern,

    pub const json_field_names = .{
        .global_confidence_level = "globalConfidenceLevel",
        .global_enforced_urls = "globalEnforcedUrls",
        .global_exempt_urls = "globalExemptUrls",
        .inline_redaction_patterns = "inlineRedactionPatterns",
    };
};
