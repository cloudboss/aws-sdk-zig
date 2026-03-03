const std = @import("std");

pub const InstanceFleetState = enum {
    provisioning,
    bootstrapping,
    running,
    resizing,
    reconfiguring,
    suspended,
    terminating,
    terminated,

    pub const json_field_names = .{
        .provisioning = "PROVISIONING",
        .bootstrapping = "BOOTSTRAPPING",
        .running = "RUNNING",
        .resizing = "RESIZING",
        .reconfiguring = "RECONFIGURING",
        .suspended = "SUSPENDED",
        .terminating = "TERMINATING",
        .terminated = "TERMINATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .provisioning => "PROVISIONING",
            .bootstrapping => "BOOTSTRAPPING",
            .running => "RUNNING",
            .resizing => "RESIZING",
            .reconfiguring => "RECONFIGURING",
            .suspended => "SUSPENDED",
            .terminating => "TERMINATING",
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
