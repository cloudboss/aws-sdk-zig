const std = @import("std");

/// State of a logging configuration.
pub const LoggingConfigurationStatusCode = enum {
    /// Logging configuration is being created. Update/Deletion is disallowed until
    /// logging configuration is ACTIVE and workspace status is ACTIVE.
    creating,
    /// Logging configuration has been created/updated. Update/Deletion is
    /// disallowed until logging configuration is ACTIVE and workspace status is
    /// ACTIVE.
    active,
    /// Logging configuration is being updated. Update/Deletion is disallowed until
    /// logging configuration is ACTIVE and workspace status is ACTIVE.
    updating,
    /// Logging configuration is being deleting. Update/Deletion is disallowed until
    /// logging configuration is ACTIVE and workspace status is ACTIVE.
    deleting,
    /// Logging configuration creation failed.
    creation_failed,
    /// Logging configuration update failed.
    update_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .creation_failed = "CREATION_FAILED",
        .update_failed = "UPDATE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .active => "ACTIVE",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .creation_failed => "CREATION_FAILED",
            .update_failed => "UPDATE_FAILED",
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
