/// Inspect one of the headers in the web request, identified by name, for
/// example,
/// `User-Agent` or `Referer`. The name isn't case sensitive.
///
/// You can filter and inspect all headers with the `FieldToMatch` setting
/// `Headers`.
///
/// This is used to indicate the web request component to inspect, in the
/// FieldToMatch specification.
///
/// Example JSON: `"SingleHeader": { "Name": "haystack" }`
pub const SingleHeader = struct {
    /// The name of the query header to inspect.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
