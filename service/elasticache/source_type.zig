const std = @import("std");

pub const SourceType = enum {
    cache_cluster,
    cache_parameter_group,
    cache_security_group,
    cache_subnet_group,
    replication_group,
    serverless_cache,
    serverless_cache_snapshot,
    user,
    user_group,

    pub const json_field_names = .{
        .cache_cluster = "cache-cluster",
        .cache_parameter_group = "cache-parameter-group",
        .cache_security_group = "cache-security-group",
        .cache_subnet_group = "cache-subnet-group",
        .replication_group = "replication-group",
        .serverless_cache = "serverless-cache",
        .serverless_cache_snapshot = "serverless-cache-snapshot",
        .user = "user",
        .user_group = "user-group",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cache_cluster => "cache-cluster",
            .cache_parameter_group => "cache-parameter-group",
            .cache_security_group => "cache-security-group",
            .cache_subnet_group => "cache-subnet-group",
            .replication_group => "replication-group",
            .serverless_cache => "serverless-cache",
            .serverless_cache_snapshot => "serverless-cache-snapshot",
            .user => "user",
            .user_group => "user-group",
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
