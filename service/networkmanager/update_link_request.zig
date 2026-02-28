const Bandwidth = @import("bandwidth.zig").Bandwidth;

pub const UpdateLinkRequest = struct {
    /// The upload and download speed in Mbps.
    bandwidth: ?Bandwidth,

    /// A description of the link.
    ///
    /// Constraints: Maximum length of 256 characters.
    description: ?[]const u8,

    /// The ID of the global network.
    global_network_id: []const u8,

    /// The ID of the link.
    link_id: []const u8,

    /// The provider of the link.
    ///
    /// Constraints: Maximum length of 128 characters.
    provider: ?[]const u8,

    /// The type of the link.
    ///
    /// Constraints: Maximum length of 128 characters.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .bandwidth = "Bandwidth",
        .description = "Description",
        .global_network_id = "GlobalNetworkId",
        .link_id = "LinkId",
        .provider = "Provider",
        .@"type" = "Type",
    };
};
