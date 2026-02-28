const MedicalScribeSessionControlEventType = @import("medical_scribe_session_control_event_type.zig").MedicalScribeSessionControlEventType;

/// Specify the lifecycle of your streaming session.
pub const MedicalScribeSessionControlEvent = struct {
    /// The type of `MedicalScribeSessionControlEvent`.
    ///
    /// Possible Values:
    ///
    /// * `END_OF_SESSION` - Indicates the audio streaming is complete. After you
    /// send an END_OF_SESSION event, Amazon Web Services HealthScribe starts the
    /// post-stream analytics.
    /// The session can't be resumed after this event is sent. After Amazon Web
    /// Services HealthScribe processes the event, the real-time `StreamStatus` is
    /// `COMPLETED`.
    /// You get the `StreamStatus` and other stream details with the
    /// [GetMedicalScribeStream](https://docs.aws.amazon.com/transcribe/latest/APIReference/API_streaming_GetMedicalScribeStream.html) API operation.
    /// For more information about different streaming statuses, see the
    /// `StreamStatus` description in the
    /// [MedicalScribeStreamDetails](https://docs.aws.amazon.com/transcribe/latest/APIReference/API_streaming_MedicalScribeStreamDetails.html).
    @"type": MedicalScribeSessionControlEventType,

    pub const json_field_names = .{
        .@"type" = "Type",
    };
};
