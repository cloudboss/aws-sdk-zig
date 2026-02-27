/// Hls Akamai Http Transfer Mode
pub const HlsAkamaiHttpTransferMode = enum {
    chunked,
    non_chunked,

    pub const json_field_names = .{
        .chunked = "CHUNKED",
        .non_chunked = "NON_CHUNKED",
    };
};
