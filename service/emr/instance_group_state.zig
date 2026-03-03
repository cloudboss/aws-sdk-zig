const std = @import("std");

pub const InstanceGroupState = enum {
    provisioning,
    bootstrapping,
    running,
    reconfiguring,
    resizing,
    suspended,
    terminating,
    terminated,
    arrested,
    shutting_down,
    ended,

    pub const json_field_names = .{
        .provisioning = "PROVISIONING",
        .bootstrapping = "BOOTSTRAPPING",
        .running = "RUNNING",
        .reconfiguring = "RECONFIGURING",
        .resizing = "RESIZING",
        .suspended = "SUSPENDED",
        .terminating = "TERMINATING",
        .terminated = "TERMINATED",
        .arrested = "ARRESTED",
        .shutting_down = "SHUTTING_DOWN",
        .ended = "ENDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .provisioning => "PROVISIONING",
            .bootstrapping => "BOOTSTRAPPING",
            .running => "RUNNING",
            .reconfiguring => "RECONFIGURING",
            .resizing => "RESIZING",
            .suspended => "SUSPENDED",
            .terminating => "TERMINATING",
            .terminated => "TERMINATED",
            .arrested => "ARRESTED",
            .shutting_down => "SHUTTING_DOWN",
            .ended => "ENDED",
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
