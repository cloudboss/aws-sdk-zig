const std = @import("std");

pub const RouterInputState = enum {
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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
