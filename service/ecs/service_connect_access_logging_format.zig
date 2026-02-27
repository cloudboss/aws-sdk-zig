/// The format for Service Connect access log output. Choose TEXT for
/// human-readable logs
/// or JSON for structured data that integrates well with log analysis tools.
pub const ServiceConnectAccessLoggingFormat = enum {
    text,
    json,

    pub const json_field_names = .{
        .text = "TEXT",
        .json = "JSON",
    };
};
