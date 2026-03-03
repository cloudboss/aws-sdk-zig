const std = @import("std");

pub const ApplicationState = enum {
    creating,
    created,
    starting,
    started,
    stopping,
    stopped,
    terminated,

    pub const json_field_names = .{
        .creating = "CREATING",
        .created = "CREATED",
        .starting = "STARTING",
        .started = "STARTED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .terminated = "TERMINATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .created => "CREATED",
            .starting => "STARTING",
            .started => "STARTED",
            .stopping => "STOPPING",
            .stopped => "STOPPED",
            .terminated => "TERMINATED",
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
