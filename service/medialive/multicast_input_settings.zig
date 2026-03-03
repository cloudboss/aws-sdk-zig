/// Multicast-specific input settings.
pub const MulticastInputSettings = struct {
    /// Optionally, a source ip address to filter by for Source-specific Multicast
    /// (SSM)
    source_ip_address: ?[]const u8 = null,

    pub const json_field_names = .{
        .source_ip_address = "SourceIpAddress",
    };
};
