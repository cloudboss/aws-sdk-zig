const std = @import("std");

pub const SafeguardPolicy = enum {
    rely_on_sql_server_replication_agent,
    exclusive_automatic_truncation,
    shared_automatic_truncation,

    pub const json_field_names = .{
        .rely_on_sql_server_replication_agent = "rely-on-sql-server-replication-agent",
        .exclusive_automatic_truncation = "exclusive-automatic-truncation",
        .shared_automatic_truncation = "shared-automatic-truncation",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rely_on_sql_server_replication_agent => "rely-on-sql-server-replication-agent",
            .exclusive_automatic_truncation => "exclusive-automatic-truncation",
            .shared_automatic_truncation => "shared-automatic-truncation",
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
