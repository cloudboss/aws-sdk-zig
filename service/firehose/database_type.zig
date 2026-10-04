const std = @import("std");

pub const DatabaseType = enum {
    my_sql,
    postgre_sql,

    pub const json_field_names = .{
        .my_sql = "MySQL",
        .postgre_sql = "PostgreSQL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .my_sql => "MySQL",
            .postgre_sql => "PostgreSQL",
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
