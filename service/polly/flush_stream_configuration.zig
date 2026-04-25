/// Configuration that controls when synthesized audio data is sent on the
/// output stream.
pub const FlushStreamConfiguration = struct {
    /// Specifies whether to force the synthesis engine to immediately
    /// write buffered audio data to the output stream.
    force: bool = false,

    pub const json_field_names = .{
        .force = "Force",
    };
};
