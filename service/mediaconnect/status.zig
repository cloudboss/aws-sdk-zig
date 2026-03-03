const std = @import("std");

pub const Status = enum {
    standby,
    active,
    updating,
    deleting,
    starting,
    stopping,
    @"error",

    pub const json_field_names = .{
        .standby = "STANDBY",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .starting = "STARTING",
        .stopping = "STOPPING",
        .@"error" = "ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standby => "STANDBY",
            .active => "ACTIVE",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .starting => "STARTING",
            .stopping => "STOPPING",
            .@"error" => "ERROR",
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
