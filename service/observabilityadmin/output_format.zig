/// Enumeration of supported output formats for ELB access logs: PLAIN for
/// space-delimited format, JSON for structured JSON format.
pub const OutputFormat = enum {
    plain,
    json,

    pub const json_field_names = .{
        .plain = "PLAIN",
        .json = "JSON",
    };
};
