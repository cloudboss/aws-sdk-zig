/// Specify the file format for your wave audio output. To use a RIFF wave
/// format: Keep the default value, RIFF. If your output audio is likely to
/// exceed 4GB in file size, or if you otherwise need the extended support of
/// the RF64 format: Choose RF64. If your player only supports the extensible
/// wave format: Choose Extensible.
pub const WavFormat = enum {
    riff,
    rf64,
    extensible,

    pub const json_field_names = .{
        .riff = "RIFF",
        .rf64 = "RF64",
        .extensible = "EXTENSIBLE",
    };
};
