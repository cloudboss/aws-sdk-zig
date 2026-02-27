const ViewDialect = @import("view_dialect.zig").ViewDialect;

/// A structure specifying the dialect and dialect version used by the query
/// engine.
pub const SupportedDialect = struct {
    /// The dialect of the query engine.
    dialect: ?ViewDialect,

    /// The version of the dialect of the query engine. For example, 3.0.0.
    dialect_version: ?[]const u8,

    pub const json_field_names = .{
        .dialect = "Dialect",
        .dialect_version = "DialectVersion",
    };
};
