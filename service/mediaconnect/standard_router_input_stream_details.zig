/// Configuration details for a standard router input stream type.
pub const StandardRouterInputStreamDetails = struct {
    /// The source IP address for the standard router input stream.
    source_ip_address: ?[]const u8,

    pub const json_field_names = .{
        .source_ip_address = "SourceIpAddress",
    };
};
