const aws = @import("aws");

const CompressionMethod = @import("compression_method.zig").CompressionMethod;
const Method = @import("method.zig").Method;

/// HTTP request configuration parameters that define how MediaTailor
/// communicates with the ad decision server.
pub const HttpRequest = struct {
    /// The request body content to send with HTTP requests to the ad decision
    /// server. This value is only eligible for `POST` requests.
    body: ?[]const u8,

    /// The compression method to apply to requests sent to the ad decision server.
    /// Supported values are `NONE` and `GZIP`. This value is only eligible for
    /// `POST` requests.
    compress_request: ?CompressionMethod,

    /// Custom HTTP headers to include in requests to the ad decision server.
    /// Specify headers as key-value pairs. This value is only eligible for `POST`
    /// requests.
    headers: ?[]const aws.map.StringMapEntry,

    /// The HTTP method to use when making requests to the ad decision server.
    /// Supported values are `GET` and `POST`.
    method: ?Method,

    pub const json_field_names = .{
        .body = "Body",
        .compress_request = "CompressRequest",
        .headers = "Headers",
        .method = "Method",
    };
};
