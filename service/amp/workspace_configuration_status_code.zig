const std = @import("std");

pub const WorkspaceConfigurationStatusCode = enum {
    /// Workspace configuration has been updated. Update is disallowed until
    /// workspace configuration is ACTIVE and workspace status is ACTIVE.
    active,
    /// Workspace configuration is being updated. Update is disallowed until
    /// workspace configuration is ACTIVE and workspace status is ACTIVE.
    updating,
    /// Workspace configuration update failed.
    update_failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .updating => "UPDATING",
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
