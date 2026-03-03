/// The properties of a table.
pub const TableMember = struct {
    /// The name of the table.
    name: ?[]const u8 = null,

    /// The schema containing the table.
    schema: ?[]const u8 = null,

    /// The type of the table. Possible values include TABLE, VIEW, SYSTEM TABLE,
    /// GLOBAL TEMPORARY, LOCAL TEMPORARY, ALIAS, and SYNONYM.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .schema = "schema",
        .@"type" = "type",
    };
};
