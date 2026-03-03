const std = @import("std");

pub const GeneratedQueryType = enum {
    redshift_sql,

    pub const json_field_names = .{
        .redshift_sql = "REDSHIFT_SQL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .redshift_sql => "REDSHIFT_SQL",
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
