const std = @import("std");

pub const OverallDeploymentStatus = enum {
    pending_deployment,
    in_progress,
    successful,
    failed_validation,
    failed_deployment,

    pub const json_field_names = .{
        .pending_deployment = "PENDING_DEPLOYMENT",
        .in_progress = "IN_PROGRESS",
        .successful = "SUCCESSFUL",
        .failed_validation = "FAILED_VALIDATION",
        .failed_deployment = "FAILED_DEPLOYMENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_deployment => "PENDING_DEPLOYMENT",
            .in_progress => "IN_PROGRESS",
            .successful => "SUCCESSFUL",
            .failed_validation => "FAILED_VALIDATION",
            .failed_deployment => "FAILED_DEPLOYMENT",
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
