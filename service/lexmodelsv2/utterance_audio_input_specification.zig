/// Contains information about the audio for an utterance.
pub const UtteranceAudioInputSpecification = struct {
    /// Amazon S3 file pointing to the audio.
    audio_file_s3_location: []const u8,

    pub const json_field_names = .{
        .audio_file_s3_location = "audioFileS3Location",
    };
};
