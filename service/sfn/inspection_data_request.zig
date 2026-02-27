/// Contains additional details about the state's execution, including its input
/// and output data processing flow, and HTTP request information.
pub const InspectionDataRequest = struct {
    /// The request body for the HTTP request.
    body: ?[]const u8,

    /// The request headers associated with the HTTP request.
    headers: ?[]const u8,

    /// The HTTP method used for the HTTP request.
    method: ?[]const u8,

    /// The protocol used to make the HTTP request.
    protocol: ?[]const u8,

    /// The API endpoint used for the HTTP request.
    url: ?[]const u8,

    pub const json_field_names = .{
        .body = "body",
        .headers = "headers",
        .method = "method",
        .protocol = "protocol",
        .url = "url",
    };
};
