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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
