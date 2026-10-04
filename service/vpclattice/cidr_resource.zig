/// Describes a CIDR resource, which represents a network segment as one or more
/// CIDR ranges.
pub const CidrResource = struct {
    /// The CIDR ranges of the network segment, for example, `10.0.0.0/16`.
    cidr_ranges: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .cidr_ranges = "cidrRanges",
    };
};
