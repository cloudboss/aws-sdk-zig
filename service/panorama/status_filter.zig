const std = @import("std");

pub const StatusFilter = enum {
    deployment_succeeded,
    deployment_error,
    removal_succeeded,
    removal_failed,
    processing_deployment,
    processing_removal,
    deployment_failed,

    pub const json_field_names = .{
        .deployment_succeeded = "DEPLOYMENT_SUCCEEDED",
        .deployment_error = "DEPLOYMENT_ERROR",
        .removal_succeeded = "REMOVAL_SUCCEEDED",
        .removal_failed = "REMOVAL_FAILED",
        .processing_deployment = "PROCESSING_DEPLOYMENT",
        .processing_removal = "PROCESSING_REMOVAL",
        .deployment_failed = "DEPLOYMENT_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .deployment_succeeded => "DEPLOYMENT_SUCCEEDED",
            .deployment_error => "DEPLOYMENT_ERROR",
            .removal_succeeded => "REMOVAL_SUCCEEDED",
            .removal_failed => "REMOVAL_FAILED",
            .processing_deployment => "PROCESSING_DEPLOYMENT",
            .processing_removal => "PROCESSING_REMOVAL",
            .deployment_failed => "DEPLOYMENT_FAILED",
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
