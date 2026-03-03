const AllocationType = @import("allocation_type.zig").AllocationType;

/// Provides information of the IP address.
pub const IpAddressMember = struct {
    /// The type of allocation for the IP address.
    allocation_type: ?AllocationType = null,

    /// The IP address.
    ip_address: ?[]const u8 = null,

    /// The primary IP address.
    primary: ?bool = null,

    pub const json_field_names = .{
        .allocation_type = "AllocationType",
        .ip_address = "IpAddress",
        .primary = "Primary",
    };
};
