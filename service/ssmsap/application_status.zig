const std = @import("std");

pub const ApplicationStatus = enum {
    activated,
    starting,
    stopped,
    stopping,
    failed,
    registering,
    deleting,
    unknown,

    pub const json_field_names = .{
        .activated = "ACTIVATED",
        .starting = "STARTING",
        .stopped = "STOPPED",
        .stopping = "STOPPING",
        .failed = "FAILED",
        .registering = "REGISTERING",
        .deleting = "DELETING",
        .unknown = "UNKNOWN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .activated => "ACTIVATED",
            .starting => "STARTING",
            .stopped => "STOPPED",
            .stopping => "STOPPING",
            .failed => "FAILED",
            .registering => "REGISTERING",
            .deleting => "DELETING",
            .unknown => "UNKNOWN",
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
