const std = @import("std");

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

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .athena => "ATHENA",
            .glue_interactive_session => "GLUE_INTERACTIVE_SESSION",
            .https => "HTTPS",
            .jdbc => "JDBC",
            .livy => "LIVY",
            .odbc => "ODBC",
            .prism => "PRISM",
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
