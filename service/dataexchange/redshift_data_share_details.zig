/// Extra details specific to the affected scope in this Redshift data set.
pub const RedshiftDataShareDetails = struct {
    /// The
    /// ARN of the underlying Redshift data share that is being affected by this
    /// notification.
    arn: []const u8,

    /// The
    /// database name in the Redshift data share that is being affected by this
    /// notification.
    database: []const u8,

    /// A
    /// function name in the Redshift database that is being affected by this
    /// notification.
    function: ?[]const u8,

    /// A
    /// schema name in the Redshift database that is being affected by this
    /// notification.
    schema: ?[]const u8,

    /// A
    /// table name in the Redshift database that is being affected by this
    /// notification.
    table: ?[]const u8,

    /// A
    /// view name in the Redshift database that is being affected by this
    /// notification.
    view: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .database = "Database",
        .function = "Function",
        .schema = "Schema",
        .table = "Table",
        .view = "View",
    };
};
