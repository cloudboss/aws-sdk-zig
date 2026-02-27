pub const StatementType = enum {
    ddl,
    dml,
    utility,

    pub const json_field_names = .{
        .ddl = "DDL",
        .dml = "DML",
        .utility = "UTILITY",
    };
};
