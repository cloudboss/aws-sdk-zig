const std = @import("std");

pub const JDBCConnectionType = enum {
    sqlserver,
    mysql,
    oracle,
    postgresql,
    redshift,

    pub const json_field_names = .{
        .sqlserver = "sqlserver",
        .mysql = "mysql",
        .oracle = "oracle",
        .postgresql = "postgresql",
        .redshift = "redshift",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sqlserver => "sqlserver",
            .mysql => "mysql",
            .oracle => "oracle",
            .postgresql => "postgresql",
            .redshift => "redshift",
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
