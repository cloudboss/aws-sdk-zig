const Tag = @import("tag.zig").Tag;

/// Information for a release of the mobile SDK, including release notes and
/// tags.
///
/// The mobile SDK is not generally available. Customers who have access to the
/// mobile SDK can use it to establish and manage WAF tokens for use in HTTP(S)
/// requests from a mobile device to WAF. For more information, see
/// [WAF client application
/// integration](https://docs.aws.amazon.com/waf/latest/developerguide/waf-application-integration.html) in the *WAF Developer Guide*.
pub const MobileSdkRelease = struct {
    /// Notes describing the release.
    release_notes: ?[]const u8,

    /// The release version.
    release_version: ?[]const u8,

    /// Tags that are associated with the release.
    tags: ?[]const Tag,

    /// The timestamp of the release.
    timestamp: ?i64,

    pub const json_field_names = .{
        .release_notes = "ReleaseNotes",
        .release_version = "ReleaseVersion",
        .tags = "Tags",
        .timestamp = "Timestamp",
    };
};
