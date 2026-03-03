const std = @import("std");

pub const Permission = enum {
    all,
    select,
    alter,
    drop,
    delete,
    insert,
    create_database,
    create_table,
    data_location_access,

    pub const json_field_names = .{
        .all = "ALL",
        .select = "SELECT",
        .alter = "ALTER",
        .drop = "DROP",
        .delete = "DELETE",
        .insert = "INSERT",
        .create_database = "CREATE_DATABASE",
        .create_table = "CREATE_TABLE",
        .data_location_access = "DATA_LOCATION_ACCESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all => "ALL",
            .select => "SELECT",
            .alter => "ALTER",
            .drop => "DROP",
            .delete => "DELETE",
            .insert => "INSERT",
            .create_database => "CREATE_DATABASE",
            .create_table => "CREATE_TABLE",
            .data_location_access => "DATA_LOCATION_ACCESS",
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
