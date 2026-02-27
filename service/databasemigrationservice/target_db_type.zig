pub const TargetDbType = enum {
    specific_database,
    multiple_databases,

    pub const json_field_names = .{
        .specific_database = "SPECIFIC_DATABASE",
        .multiple_databases = "MULTIPLE_DATABASES",
    };
};
