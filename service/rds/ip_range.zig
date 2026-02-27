/// This data type is used as a response element in the
/// `DescribeDBSecurityGroups` action.
pub const IPRange = struct {
    /// The IP range.
    cidrip: ?[]const u8,

    /// The status of the IP range. Status can be "authorizing", "authorized",
    /// "revoking", and "revoked".
    status: ?[]const u8,
};
