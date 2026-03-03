const ObjectIdentifierAndLinkNameTuple = @import("object_identifier_and_link_name_tuple.zig").ObjectIdentifierAndLinkNameTuple;

/// Represents the output of a ListObjectParents response operation.
pub const BatchListObjectParentsResponse = struct {
    /// The pagination token.
    next_token: ?[]const u8 = null,

    /// Returns a list of parent reference and LinkName Tuples.
    parent_links: ?[]const ObjectIdentifierAndLinkNameTuple = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .parent_links = "ParentLinks",
    };
};
