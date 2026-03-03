const UtteranceData = @import("utterance_data.zig").UtteranceData;

/// Provides a list of utterances that have been made to a specific
/// version of your bot. The list contains a maximum of 100
/// utterances.
pub const UtteranceList = struct {
    /// The version of the bot that processed the list.
    bot_version: ?[]const u8 = null,

    /// One or more UtteranceData objects that contain
    /// information about the utterances that have been made to a bot. The maximum
    /// number of object is 100.
    utterances: ?[]const UtteranceData = null,

    pub const json_field_names = .{
        .bot_version = "botVersion",
        .utterances = "utterances",
    };
};
