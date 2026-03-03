const std = @import("std");

/// The type of cluster.
pub const ClusterType = enum {
    provisioned,
    serverless,

    pub const json_field_names = .{
        .provisioned = "PROVISIONED",
        .serverless = "SERVERLESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .provisioned => "PROVISIONED",
            .serverless => "SERVERLESS",
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
