const CursorConfiguration = @import("cursor_configuration.zig").CursorConfiguration;
const OffsetConfiguration = @import("offset_configuration.zig").OffsetConfiguration;

/// Configuration that defines how to handle paginated responses from REST APIs,
/// supporting different pagination strategies used by various services.
pub const PaginationConfiguration = struct {
    /// Configuration for cursor-based pagination, where the API provides a cursor
    /// or token to retrieve the next page of results.
    cursor_configuration: ?CursorConfiguration = null,

    /// Configuration for offset-based pagination, where the API uses numeric
    /// offsets and limits to control which results are returned.
    offset_configuration: ?OffsetConfiguration = null,

    pub const json_field_names = .{
        .cursor_configuration = "CursorConfiguration",
        .offset_configuration = "OffsetConfiguration",
    };
};
