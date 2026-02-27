const IdentifierParts = @import("identifier_parts.zig").IdentifierParts;

/// The REST API endpoint identifier.
pub const RestEndpointIdentifier = struct {
    /// The identifier parts of the REST endpoint identifier.
    identifier_parts: ?IdentifierParts,

    pub const json_field_names = .{
        .identifier_parts = "IdentifierParts",
    };
};
