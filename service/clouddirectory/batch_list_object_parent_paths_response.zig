const PathToObjectIdentifiers = @import("path_to_object_identifiers.zig").PathToObjectIdentifiers;

/// Represents the output of a ListObjectParentPaths response operation.
pub const BatchListObjectParentPathsResponse = struct {
    /// The pagination token.
    next_token: ?[]const u8,

    /// Returns the path to the `ObjectIdentifiers` that are associated with the
    /// directory.
    path_to_object_identifiers_list: ?[]const PathToObjectIdentifiers,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .path_to_object_identifiers_list = "PathToObjectIdentifiersList",
    };
};
