/// The configuration for a browser profile in Amazon Bedrock AgentCore. A
/// browser profile contains persistent browser data such as cookies and local
/// storage that can be saved from one browser session and reused in subsequent
/// sessions. Browser profiles enable continuity for tasks that require
/// authentication, maintain user preferences, or depend on previously stored
/// browser state.
pub const BrowserProfileConfiguration = struct {
    /// The unique identifier of the browser profile. This identifier is used to
    /// reference the profile when starting new browser sessions or saving session
    /// data to the profile.
    profile_identifier: []const u8,

    pub const json_field_names = .{
        .profile_identifier = "profileIdentifier",
    };
};
