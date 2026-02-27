/// Contains additional details about the state's execution, including its input
/// and output data processing flow, and HTTP response information. The
/// `inspectionLevel` request parameter specifies which details are returned.
pub const InspectionDataResponse = struct {
    /// The HTTP response returned.
    body: ?[]const u8,

    /// The response headers associated with the HTTP response.
    headers: ?[]const u8,

    /// The protocol used to return the HTTP response.
    protocol: ?[]const u8,

    /// The HTTP response status code for the HTTP response.
    status_code: ?[]const u8,

    /// The message associated with the HTTP status code.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .body = "body",
        .headers = "headers",
        .protocol = "protocol",
        .status_code = "statusCode",
        .status_message = "statusMessage",
    };
};
