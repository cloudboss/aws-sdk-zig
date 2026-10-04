const std = @import("std");

pub const InferenceExperimentStatus = enum {
    creating,
    created,
    updating,
    running,
    starting,
    stopping,
    completed,
    cancelled,

    pub const json_field_names = .{
        .creating = "Creating",
        .created = "Created",
        .updating = "Updating",
        .running = "Running",
        .starting = "Starting",
        .stopping = "Stopping",
        .completed = "Completed",
        .cancelled = "Cancelled",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "Creating",
            .created => "Created",
            .updating => "Updating",
            .running => "Running",
            .starting => "Starting",
            .stopping => "Stopping",
            .completed => "Completed",
            .cancelled => "Cancelled",
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
