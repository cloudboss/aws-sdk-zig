/// Pair of multicast url and source ip address (optional) that make up a
/// multicast source.
pub const MulticastSource = struct {
    /// This represents the ip address of the device sending the multicast stream.
    source_ip: ?[]const u8,

    /// This represents the customer's source URL where multicast stream is pulled
    /// from.
    url: []const u8,

    pub const json_field_names = .{
        .source_ip = "SourceIp",
        .url = "Url",
    };
};
