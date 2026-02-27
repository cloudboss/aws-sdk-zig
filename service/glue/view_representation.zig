const ViewDialect = @import("view_dialect.zig").ViewDialect;

/// A structure that contains the dialect of the view, and the query that
/// defines the view.
pub const ViewRepresentation = struct {
    /// The dialect of the query engine.
    dialect: ?ViewDialect,

    /// The version of the dialect of the query engine. For example, 3.0.0.
    dialect_version: ?[]const u8,

    /// Dialects marked as stale are no longer valid and must be updated before they
    /// can be queried in their respective query engines.
    is_stale: ?bool,

    /// The name of the connection to be used to validate the specific
    /// representation of the view.
    validation_connection: ?[]const u8,

    /// The expanded SQL for the view. This SQL is used by engines while processing
    /// a query on a view. Engines may perform operations during view creation to
    /// transform `ViewOriginalText` to `ViewExpandedText`. For example:
    ///
    /// * Fully qualified identifiers: `SELECT * from table1 -> SELECT * from
    ///   db1.table1`
    view_expanded_text: ?[]const u8,

    /// The `SELECT` query provided by the customer during `CREATE VIEW DDL`. This
    /// SQL is not used during a query on a view (`ViewExpandedText` is used
    /// instead). `ViewOriginalText` is used for cases like `SHOW CREATE VIEW` where
    /// users want to see the original DDL command that created the view.
    view_original_text: ?[]const u8,

    pub const json_field_names = .{
        .dialect = "Dialect",
        .dialect_version = "DialectVersion",
        .is_stale = "IsStale",
        .validation_connection = "ValidationConnection",
        .view_expanded_text = "ViewExpandedText",
        .view_original_text = "ViewOriginalText",
    };
};
