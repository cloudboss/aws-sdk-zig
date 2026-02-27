const AllocationType = @import("allocation_type.zig").AllocationType;

/// Provides information of the IP address.
pub const IpAddressMember = struct {
    /// The type of allocation for the IP address.
    allocation_type: ?AllocationType,

    /// The IP address.
    ip_address: ?[]const u8,

    /// The primary IP address.
    primary: ?bool,

    pub const json_field_names = .{
        .allocation_type = "AllocationType",
        .ip_address = "IpAddress",
        .primary = "Primary",
    };
};
