const aws = @import("aws");

/// Represents the output of a ListObjectChildren response operation.
pub const BatchListObjectChildrenResponse = struct {
    /// The children structure, which is a map with the key as the `LinkName` and
    /// `ObjectIdentifier` as the value.
    children: ?[]const aws.map.StringMapEntry = null,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .children = "Children",
        .next_token = "NextToken",
    };
};
