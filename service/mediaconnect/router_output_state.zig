const std = @import("std");

pub const RouterOutputState = enum {
    creating,
    standby,
    starting,
    active,
    stopping,
    deleting,
    updating,
    @"error",
    recovering,
    migrating,

    pub const json_field_names = .{
        .creating = "CREATING",
        .standby = "STANDBY",
        .starting = "STARTING",
        .active = "ACTIVE",
        .stopping = "STOPPING",
        .deleting = "DELETING",
        .updating = "UPDATING",
        .@"error" = "ERROR",
        .recovering = "RECOVERING",
        .migrating = "MIGRATING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .standby => "STANDBY",
            .starting => "STARTING",
            .active => "ACTIVE",
            .stopping => "STOPPING",
            .deleting => "DELETING",
            .updating => "UPDATING",
            .@"error" => "ERROR",
            .recovering => "RECOVERING",
            .migrating => "MIGRATING",
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
