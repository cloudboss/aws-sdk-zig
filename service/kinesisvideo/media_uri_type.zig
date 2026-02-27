pub const MediaUriType = enum {
    rtsp_uri,
    file_uri,

    pub const json_field_names = .{
        .rtsp_uri = "RTSP_URI",
        .file_uri = "FILE_URI",
    };
};
