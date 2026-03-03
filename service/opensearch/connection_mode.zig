const std = @import("std");

/// The connection mode for the cross-cluster connection.
///
/// * **DIRECT** - Used for cross-cluster search or
/// cross-cluster replication.
///
/// * **VPC_ENDPOINT** - Used for remote reindex
/// between Amazon OpenSearch Service VPC domains.
pub const ConnectionMode = enum {
    direct,
    vpc_endpoint,

    pub const json_field_names = .{
        .direct = "DIRECT",
        .vpc_endpoint = "VPC_ENDPOINT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .direct => "DIRECT",
            .vpc_endpoint => "VPC_ENDPOINT",
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
