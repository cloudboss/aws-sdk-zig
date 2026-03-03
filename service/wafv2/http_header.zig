/// Part of the response from GetSampledRequests. This is a complex type
/// that appears as `Headers` in the response syntax. `HTTPHeader`
/// contains the names and values of all of the headers that appear in one of
/// the web requests.
pub const HTTPHeader = struct {
    /// The name of the HTTP header.
    name: ?[]const u8 = null,

    /// The value of the HTTP header.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
