/// The IP filter for querying findings.
pub const IpFilter = struct {
    /// A finding's CIDR value.
    cidr: ?[]const u8 = null,

    pub const json_field_names = .{
        .cidr = "Cidr",
    };
};
