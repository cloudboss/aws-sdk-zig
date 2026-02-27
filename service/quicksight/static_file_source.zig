const StaticFileS3SourceOptions = @import("static_file_s3_source_options.zig").StaticFileS3SourceOptions;
const StaticFileUrlSourceOptions = @import("static_file_url_source_options.zig").StaticFileUrlSourceOptions;

/// The source of the static file.
pub const StaticFileSource = struct {
    /// The structure that contains the Amazon S3 location to download the static
    /// file from.
    s3_options: ?StaticFileS3SourceOptions,

    /// The structure that contains the URL to download the static file from.
    url_options: ?StaticFileUrlSourceOptions,

    pub const json_field_names = .{
        .s3_options = "S3Options",
        .url_options = "UrlOptions",
    };
};
