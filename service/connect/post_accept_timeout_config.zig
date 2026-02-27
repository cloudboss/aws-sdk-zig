/// Countdown timer configuration after the agent accepted the contact.
pub const PostAcceptTimeoutConfig = struct {
    /// Duration in seconds for the countdown timer after the agent accepted the
    /// contact.
    duration_in_seconds: i32,

    pub const json_field_names = .{
        .duration_in_seconds = "DurationInSeconds",
    };
};
