const std = @import("std");

/// The ungraceful behavior for an Amazon RDS switchover read replica, that is,
/// promote the read replica to a standalone primary.
pub const RdsUngracefulBehavior = enum {
    promote_read_replica,

    pub const json_field_names = .{
        .promote_read_replica = "promoteReadReplica",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .promote_read_replica => "promoteReadReplica",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
