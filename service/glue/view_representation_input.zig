const ViewDialect = @import("view_dialect.zig").ViewDialect;

/// A structure containing details of a representation to update or create a
/// Lake Formation view.
pub const ViewRepresentationInput = struct {
    /// A parameter that specifies the engine type of a specific representation.
    dialect: ?ViewDialect,

    /// A parameter that specifies the version of the engine of a specific
    /// representation.
    dialect_version: ?[]const u8,

    /// The name of the connection to be used to validate the specific
    /// representation of the view.
    validation_connection: ?[]const u8,

    /// A string that represents the SQL query that describes the view with expanded
    /// resource ARNs
    view_expanded_text: ?[]const u8,

    /// A string that represents the original SQL query that describes the view.
    view_original_text: ?[]const u8,

    pub const json_field_names = .{
        .dialect = "Dialect",
        .dialect_version = "DialectVersion",
        .validation_connection = "ValidationConnection",
        .view_expanded_text = "ViewExpandedText",
        .view_original_text = "ViewOriginalText",
    };
};
