const BrowserProfileStatus = @import("browser_profile_status.zig").BrowserProfileStatus;

/// Contains summary information about a browser profile. A browser profile
/// stores persistent browser data that can be reused across browser sessions.
pub const BrowserProfileSummary = struct {
    /// The timestamp when the browser profile was created.
    created_at: i64,

    /// The description of the browser profile.
    description: ?[]const u8 = null,

    /// The timestamp when browser session data was last saved to this profile.
    last_saved_at: ?i64 = null,

    /// The identifier of the browser from which data was last saved to this
    /// profile.
    last_saved_browser_id: ?[]const u8 = null,

    /// The identifier of the browser session from which data was last saved to this
    /// profile.
    last_saved_browser_session_id: ?[]const u8 = null,

    /// The timestamp when the browser profile was last updated.
    last_updated_at: i64,

    /// The name of the browser profile.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the browser profile.
    profile_arn: []const u8,

    /// The unique identifier of the browser profile.
    profile_id: []const u8,

    /// The current status of the browser profile. Possible values include READY,
    /// SAVING, DELETING, and DELETED.
    status: BrowserProfileStatus,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .last_saved_at = "lastSavedAt",
        .last_saved_browser_id = "lastSavedBrowserId",
        .last_saved_browser_session_id = "lastSavedBrowserSessionId",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .profile_arn = "profileArn",
        .profile_id = "profileId",
        .status = "status",
    };
};
