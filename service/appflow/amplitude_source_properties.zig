/// The properties that are applied when Amplitude is being used as a source.
pub const AmplitudeSourceProperties = struct {
    /// The object specified in the Amplitude flow source.
    object: []const u8,

    pub const json_field_names = .{
        .object = "object",
    };
};
