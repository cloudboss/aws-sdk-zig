/// If INSERT, Nielsen inaudible tones for media tracking will be detected in
/// the input audio and an equivalent ID3 tag will be inserted in the output.
pub const M3u8NielsenId3 = enum {
    insert,
    none,

    pub const json_field_names = .{
        .insert = "INSERT",
        .none = "NONE",
    };
};
