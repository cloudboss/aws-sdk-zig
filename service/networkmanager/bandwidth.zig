/// Describes bandwidth information.
pub const Bandwidth = struct {
    /// Download speed in Mbps.
    download_speed: ?i32,

    /// Upload speed in Mbps.
    upload_speed: ?i32,

    pub const json_field_names = .{
        .download_speed = "DownloadSpeed",
        .upload_speed = "UploadSpeed",
    };
};
