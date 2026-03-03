const std = @import("std");

/// The state of the Apache Kafka cluster.
pub const ClusterState = enum {
    active,
    creating,
    deleting,
    failed,
    healing,
    maintenance,
    rebooting_broker,
    updating,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .creating = "CREATING",
        .deleting = "DELETING",
        .failed = "FAILED",
        .healing = "HEALING",
        .maintenance = "MAINTENANCE",
        .rebooting_broker = "REBOOTING_BROKER",
        .updating = "UPDATING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .creating => "CREATING",
            .deleting => "DELETING",
            .failed => "FAILED",
            .healing => "HEALING",
            .maintenance => "MAINTENANCE",
            .rebooting_broker => "REBOOTING_BROKER",
            .updating => "UPDATING",
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
