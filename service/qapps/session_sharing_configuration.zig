/// The sharing configuration of an Amazon Q App data collection session.
pub const SessionSharingConfiguration = struct {
    /// Indicates whether an Q App session can accept responses from users.
    accept_responses: ?bool,

    /// Indicates whether an Q App session is shareable with other users.
    enabled: bool,

    /// Indicates whether collected responses for an Q App session are revealed for
    /// all users.
    reveal_cards: ?bool,

    pub const json_field_names = .{
        .accept_responses = "acceptResponses",
        .enabled = "enabled",
        .reveal_cards = "revealCards",
    };
};
