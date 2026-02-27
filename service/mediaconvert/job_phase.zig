/// A job's phase can be PROBING, TRANSCODING OR UPLOADING
pub const JobPhase = enum {
    probing,
    transcoding,
    uploading,

    pub const json_field_names = .{
        .probing = "PROBING",
        .transcoding = "TRANSCODING",
        .uploading = "UPLOADING",
    };
};
