/// Specifies the DTMF input specifications.
pub const DTMFSpecification = struct {
    /// The DTMF character that clears the accumulated DTMF digits and immediately
    /// ends
    /// the input.
    deletion_character: []const u8,

    /// The DTMF character that immediately ends input. If the user does not press
    /// this
    /// character, the input ends after the end timeout.
    end_character: []const u8,

    /// How long the bot should wait after the last DTMF character input before
    /// assuming
    /// that the input has concluded.
    end_timeout_ms: i32,

    /// The maximum number of DTMF digits allowed in an utterance.
    max_length: i32,

    pub const json_field_names = .{
        .deletion_character = "deletionCharacter",
        .end_character = "endCharacter",
        .end_timeout_ms = "endTimeoutMs",
        .max_length = "maxLength",
    };
};
