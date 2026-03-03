const std = @import("std");

pub const TargetType = enum {
    rds_instance,
    rds_serverless_endpoint,
    tracked_cluster,

    pub const json_field_names = .{
        .rds_instance = "RDS_INSTANCE",
        .rds_serverless_endpoint = "RDS_SERVERLESS_ENDPOINT",
        .tracked_cluster = "TRACKED_CLUSTER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rds_instance => "RDS_INSTANCE",
            .rds_serverless_endpoint => "RDS_SERVERLESS_ENDPOINT",
            .tracked_cluster => "TRACKED_CLUSTER",
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
