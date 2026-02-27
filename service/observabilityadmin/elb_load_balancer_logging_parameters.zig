const OutputFormat = @import("output_format.zig").OutputFormat;

/// Configuration parameters for ELB load balancer logging, including output
/// format and field delimiter settings.
pub const ELBLoadBalancerLoggingParameters = struct {
    /// The delimiter character used to separate fields in ELB access log entries
    /// when using plain text format.
    field_delimiter: ?[]const u8,

    /// The format for ELB access log entries (plain text or JSON format).
    output_format: ?OutputFormat,

    pub const json_field_names = .{
        .field_delimiter = "FieldDelimiter",
        .output_format = "OutputFormat",
    };
};
