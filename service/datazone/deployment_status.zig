const std = @import("std");

pub const DeploymentStatus = enum {
    in_progress,
    successful,
    failed,
    pending_deployment,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .successful = "SUCCESSFUL",
        .failed = "FAILED",
        .pending_deployment = "PENDING_DEPLOYMENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "IN_PROGRESS",
            .successful => "SUCCESSFUL",
            .failed => "FAILED",
            .pending_deployment => "PENDING_DEPLOYMENT",
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
