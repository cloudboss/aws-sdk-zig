pub const RecordingFileFormat = enum {
    wav,
    opus,

    pub const json_field_names = .{
        .wav = "Wav",
        .opus = "Opus",
    };
};
