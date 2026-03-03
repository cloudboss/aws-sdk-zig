const std = @import("std");

pub const Permission = enum {
    all,
    select,
    alter,
    drop,
    delete,
    insert,
    describe,
    create_database,
    create_table,
    data_location_access,
    create_lf_tag,
    associate,
    grant_with_lf_tag_expression,
    create_lf_tag_expression,
    create_catalog,
    super_user,

    pub const json_field_names = .{
        .all = "ALL",
        .select = "SELECT",
        .alter = "ALTER",
        .drop = "DROP",
        .delete = "DELETE",
        .insert = "INSERT",
        .describe = "DESCRIBE",
        .create_database = "CREATE_DATABASE",
        .create_table = "CREATE_TABLE",
        .data_location_access = "DATA_LOCATION_ACCESS",
        .create_lf_tag = "CREATE_LF_TAG",
        .associate = "ASSOCIATE",
        .grant_with_lf_tag_expression = "GRANT_WITH_LF_TAG_EXPRESSION",
        .create_lf_tag_expression = "CREATE_LF_TAG_EXPRESSION",
        .create_catalog = "CREATE_CATALOG",
        .super_user = "SUPER_USER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all => "ALL",
            .select => "SELECT",
            .alter => "ALTER",
            .drop => "DROP",
            .delete => "DELETE",
            .insert => "INSERT",
            .describe => "DESCRIBE",
            .create_database => "CREATE_DATABASE",
            .create_table => "CREATE_TABLE",
            .data_location_access => "DATA_LOCATION_ACCESS",
            .create_lf_tag => "CREATE_LF_TAG",
            .associate => "ASSOCIATE",
            .grant_with_lf_tag_expression => "GRANT_WITH_LF_TAG_EXPRESSION",
            .create_lf_tag_expression => "CREATE_LF_TAG_EXPRESSION",
            .create_catalog => "CREATE_CATALOG",
            .super_user => "SUPER_USER",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
