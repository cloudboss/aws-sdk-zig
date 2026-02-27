/// Hls Webdav Http Transfer Mode
pub const HlsWebdavHttpTransferMode = enum {
    chunked,
    non_chunked,

    pub const json_field_names = .{
        .chunked = "CHUNKED",
        .non_chunked = "NON_CHUNKED",
    };
};
