/// Provides the status code and message that result from processing data for an
/// endpoint.
pub const EndpointItemResponse = struct {
    /// The custom message that's returned in the response as a result of processing
    /// the endpoint data.
    message: ?[]const u8 = null,

    /// The status code that's returned in the response as a result of processing
    /// the endpoint data.
    status_code: ?i32 = null,

    pub const json_field_names = .{
        .message = "Message",
        .status_code = "StatusCode",
    };
};
