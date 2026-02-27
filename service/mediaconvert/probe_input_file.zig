/// The input file that needs to be analyzed.
pub const ProbeInputFile = struct {
    /// Specify the S3, HTTP, or HTTPS URL for your media file.
    file_url: ?[]const u8,

    pub const json_field_names = .{
        .file_url = "FileUrl",
    };
};
