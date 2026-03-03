const std = @import("std");

pub const SourceType = enum {
    db_instance,
    db_parameter_group,
    db_security_group,
    db_snapshot,
    db_cluster,
    db_cluster_snapshot,
    custom_engine_version,
    db_proxy,
    blue_green_deployment,
    db_shard_group,
    zero_etl,

    pub const json_field_names = .{
        .db_instance = "db-instance",
        .db_parameter_group = "db-parameter-group",
        .db_security_group = "db-security-group",
        .db_snapshot = "db-snapshot",
        .db_cluster = "db-cluster",
        .db_cluster_snapshot = "db-cluster-snapshot",
        .custom_engine_version = "custom-engine-version",
        .db_proxy = "db-proxy",
        .blue_green_deployment = "blue-green-deployment",
        .db_shard_group = "db-shard-group",
        .zero_etl = "zero-etl",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .db_instance => "db-instance",
            .db_parameter_group => "db-parameter-group",
            .db_security_group => "db-security-group",
            .db_snapshot => "db-snapshot",
            .db_cluster => "db-cluster",
            .db_cluster_snapshot => "db-cluster-snapshot",
            .custom_engine_version => "custom-engine-version",
            .db_proxy => "db-proxy",
            .blue_green_deployment => "blue-green-deployment",
            .db_shard_group => "db-shard-group",
            .zero_etl => "zero-etl",
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
