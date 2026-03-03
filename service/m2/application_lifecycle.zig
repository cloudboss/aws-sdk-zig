const std = @import("std");

pub const ApplicationLifecycle = enum {
    creating,
    created,
    available,
    ready,
    starting,
    running,
    stopping,
    stopped,
    failed,
    deleting,
    deleting_from_environment,

    pub const json_field_names = .{
        .creating = "Creating",
        .created = "Created",
        .available = "Available",
        .ready = "Ready",
        .starting = "Starting",
        .running = "Running",
        .stopping = "Stopping",
        .stopped = "Stopped",
        .failed = "Failed",
        .deleting = "Deleting",
        .deleting_from_environment = "Deleting From Environment",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "Creating",
            .created => "Created",
            .available => "Available",
            .ready => "Ready",
            .starting => "Starting",
            .running => "Running",
            .stopping => "Stopping",
            .stopped => "Stopped",
            .failed => "Failed",
            .deleting => "Deleting",
            .deleting_from_environment => "Deleting From Environment",
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
