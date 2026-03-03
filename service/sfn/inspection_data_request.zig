/// Contains additional details about the state's execution, including its input
/// and output data processing flow, and HTTP request information.
pub const InspectionDataRequest = struct {
    /// The request body for the HTTP request.
    body: ?[]const u8 = null,

    /// The request headers associated with the HTTP request.
    headers: ?[]const u8 = null,

    /// The HTTP method used for the HTTP request.
    method: ?[]const u8 = null,

    /// The protocol used to make the HTTP request.
    protocol: ?[]const u8 = null,

    /// The API endpoint used for the HTTP request.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .body = "body",
        .headers = "headers",
        .method = "method",
        .protocol = "protocol",
        .url = "url",
    };
};
