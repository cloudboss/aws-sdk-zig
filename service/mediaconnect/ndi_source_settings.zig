/// The settings for the NDI® source. This includes the exact name of the
/// upstream NDI sender that you want to connect to your source.
///
/// When you update the NDI source, include only the members you want to change.
/// MediaConnect leaves the members that you don't specify unchanged.
pub const NdiSourceSettings = struct {
    /// The audio reference level of the NDI sender, in decibels relative to full
    /// scale (dBFS). Common values are `-20` (NDI and SMPTE) and `-18` (EBU). If
    /// you don't specify this field, MediaConnect uses `-20`.
    audio_reference_level: ?i32 = null,

    /// The exact name of an existing NDI sender that's registered with your
    /// discovery server. If included, the format of this name must be `MACHINENAME
    /// (ProgramName)`.
    source_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .audio_reference_level = "AudioReferenceLevel",
        .source_name = "SourceName",
    };
};
