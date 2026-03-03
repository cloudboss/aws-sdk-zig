const std = @import("std");

/// Replication direction designates if this is a failover replication, or a
/// failback replication. When a DRS agent is installed on an instance, the
/// replication direction is failover. In cases where a recovery launch was made
/// in the recovery location and a new recovery instance was created, and then a
/// failback replication was initiated from that recovery instance back to the
/// origin location, then the replication direction will be failback.
pub const ReplicationDirection = enum {
    failover,
    failback,

    pub const json_field_names = .{
        .failover = "FAILOVER",
        .failback = "FAILBACK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .failover => "FAILOVER",
            .failback => "FAILBACK",
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
