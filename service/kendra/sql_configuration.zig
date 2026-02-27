const QueryIdentifiersEnclosingOption = @import("query_identifiers_enclosing_option.zig").QueryIdentifiersEnclosingOption;

/// Provides the configuration information to use a SQL database.
pub const SqlConfiguration = struct {
    /// Determines whether Amazon Kendra encloses SQL identifiers for tables and
    /// column
    /// names in double quotes (") when making a database query.
    ///
    /// By default, Amazon Kendra passes SQL identifiers the way that they are
    /// entered
    /// into the data source configuration. It does not change the case of
    /// identifiers or
    /// enclose them in quotes.
    ///
    /// PostgreSQL internally converts uppercase characters to lower case characters
    /// in
    /// identifiers unless they are quoted. Choosing this option encloses
    /// identifiers in quotes
    /// so that PostgreSQL does not convert the character's case.
    ///
    /// For MySQL databases, you must enable the `ansi_quotes` option when you set
    /// this field to `DOUBLE_QUOTES`.
    query_identifiers_enclosing_option: ?QueryIdentifiersEnclosingOption,

    pub const json_field_names = .{
        .query_identifiers_enclosing_option = "QueryIdentifiersEnclosingOption",
    };
};
