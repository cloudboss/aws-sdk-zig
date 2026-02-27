/// The settings related to the multicast source.
pub const MulticastSourceSettings = struct {
    /// The IP address of the source for source-specific multicast (SSM).
    multicast_source_ip: ?[]const u8,

    pub const json_field_names = .{
        .multicast_source_ip = "MulticastSourceIp",
    };
};
