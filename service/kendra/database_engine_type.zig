const std = @import("std");

pub const DatabaseEngineType = enum {
    rds_aurora_mysql,
    rds_aurora_postgresql,
    rds_mysql,
    rds_postgresql,

    pub const json_field_names = .{
        .rds_aurora_mysql = "RDS_AURORA_MYSQL",
        .rds_aurora_postgresql = "RDS_AURORA_POSTGRESQL",
        .rds_mysql = "RDS_MYSQL",
        .rds_postgresql = "RDS_POSTGRESQL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rds_aurora_mysql => "RDS_AURORA_MYSQL",
            .rds_aurora_postgresql => "RDS_AURORA_POSTGRESQL",
            .rds_mysql => "RDS_MYSQL",
            .rds_postgresql => "RDS_POSTGRESQL",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
