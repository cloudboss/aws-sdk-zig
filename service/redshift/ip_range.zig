const Tag = @import("tag.zig").Tag;

/// Describes an IP range used in a security group.
pub const IPRange = struct {
    /// The IP range in Classless Inter-Domain Routing (CIDR) notation.
    cidrip: ?[]const u8,

    /// The status of the IP range, for example, "authorized".
    status: ?[]const u8,

    /// The list of tags for the IP range.
    tags: ?[]const Tag,
};
