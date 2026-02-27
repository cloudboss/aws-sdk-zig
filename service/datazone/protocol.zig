pub const Protocol = enum {
    athena,
    glue_interactive_session,
    https,
    jdbc,
    livy,
    odbc,
    prism,

    pub const json_field_names = .{
        .athena = "ATHENA",
        .glue_interactive_session = "GLUE_INTERACTIVE_SESSION",
        .https = "HTTPS",
        .jdbc = "JDBC",
        .livy = "LIVY",
        .odbc = "ODBC",
        .prism = "PRISM",
    };
};
