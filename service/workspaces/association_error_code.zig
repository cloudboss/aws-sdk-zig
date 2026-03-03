const std = @import("std");

pub const AssociationErrorCode = enum {
    insufficient_diskspace,
    insufficient_memory,
    unsupported_operating_system,
    internal_server_error,
    workspace_unreachable,
    application_oldversionexist_failure,

    pub const json_field_names = .{
        .insufficient_diskspace = "ValidationError.InsufficientDiskSpace",
        .insufficient_memory = "ValidationError.InsufficientMemory",
        .unsupported_operating_system = "ValidationError.UnsupportedOperatingSystem",
        .internal_server_error = "DeploymentError.InternalServerError",
        .workspace_unreachable = "DeploymentError.WorkspaceUnreachable",
        .application_oldversionexist_failure = "ValidationError.ApplicationOldVersionExists",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .insufficient_diskspace => "ValidationError.InsufficientDiskSpace",
            .insufficient_memory => "ValidationError.InsufficientMemory",
            .unsupported_operating_system => "ValidationError.UnsupportedOperatingSystem",
            .internal_server_error => "DeploymentError.InternalServerError",
            .workspace_unreachable => "DeploymentError.WorkspaceUnreachable",
            .application_oldversionexist_failure => "ValidationError.ApplicationOldVersionExists",
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
