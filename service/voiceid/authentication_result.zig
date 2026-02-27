const AuthenticationConfiguration = @import("authentication_configuration.zig").AuthenticationConfiguration;
const AuthenticationDecision = @import("authentication_decision.zig").AuthenticationDecision;

/// The authentication result produced by Voice ID, processed against the
/// current session
/// state and streamed audio of the speaker.
pub const AuthenticationResult = struct {
    /// A timestamp of when audio aggregation ended for this authentication
    /// result.
    audio_aggregation_ended_at: ?i64,

    /// A timestamp of when audio aggregation started for this authentication
    /// result.
    audio_aggregation_started_at: ?i64,

    /// The unique identifier for this authentication result. Because there can be
    /// multiple
    /// authentications for a given session, this field helps to identify if the
    /// returned result
    /// is from a previous streaming activity or a new result. Note that in absence
    /// of any new
    /// streaming activity, `AcceptanceThreshold` changes, or `SpeakerId`
    /// changes, Voice ID always returns cached Authentication Result for this API.
    authentication_result_id: ?[]const u8,

    /// The `AuthenticationConfiguration` used to generate this authentication
    /// result.
    configuration: ?AuthenticationConfiguration,

    /// The client-provided identifier for the speaker whose authentication result
    /// is
    /// produced. Only present if a `SpeakerId` is provided for the session.
    customer_speaker_id: ?[]const u8,

    /// The authentication decision produced by Voice ID, processed against the
    /// current
    /// session state and streamed audio of the speaker.
    decision: ?AuthenticationDecision,

    /// The service-generated identifier for the speaker whose authentication result
    /// is
    /// produced.
    generated_speaker_id: ?[]const u8,

    /// The authentication score for the speaker whose authentication result is
    /// produced. This
    /// value is only present if the authentication decision is either `ACCEPT` or
    /// `REJECT`.
    score: ?i32,

    pub const json_field_names = .{
        .audio_aggregation_ended_at = "AudioAggregationEndedAt",
        .audio_aggregation_started_at = "AudioAggregationStartedAt",
        .authentication_result_id = "AuthenticationResultId",
        .configuration = "Configuration",
        .customer_speaker_id = "CustomerSpeakerId",
        .decision = "Decision",
        .generated_speaker_id = "GeneratedSpeakerId",
        .score = "Score",
    };
};
