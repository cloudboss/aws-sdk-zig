const std = @import("std");

pub const ClientPasswordAuthType = enum {
    mysql_native_password,
    mysql_caching_sha2_password,
    postgres_scram_sha_256,
    postgres_md5,
    sql_server_authentication,

    pub const json_field_names = .{
        .mysql_native_password = "MYSQL_NATIVE_PASSWORD",
        .mysql_caching_sha2_password = "MYSQL_CACHING_SHA2_PASSWORD",
        .postgres_scram_sha_256 = "POSTGRES_SCRAM_SHA_256",
        .postgres_md5 = "POSTGRES_MD5",
        .sql_server_authentication = "SQL_SERVER_AUTHENTICATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mysql_native_password => "MYSQL_NATIVE_PASSWORD",
            .mysql_caching_sha2_password => "MYSQL_CACHING_SHA2_PASSWORD",
            .postgres_scram_sha_256 => "POSTGRES_SCRAM_SHA_256",
            .postgres_md5 => "POSTGRES_MD5",
            .sql_server_authentication => "SQL_SERVER_AUTHENTICATION",
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
