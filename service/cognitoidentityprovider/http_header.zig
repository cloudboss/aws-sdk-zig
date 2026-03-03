/// The HTTP header in the `ContextData` parameter.
pub const HttpHeader = struct {
    /// The header name.
    header_name: ?[]const u8 = null,

    /// The header value.
    header_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .header_name = "headerName",
        .header_value = "headerValue",
    };
};
