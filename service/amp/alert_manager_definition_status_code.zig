const std = @import("std");

/// State of an `AlertManagerDefinition`.
pub const AlertManagerDefinitionStatusCode = enum {
    /// Definition is being created. Update/Deletion is disallowed until definition
    /// is ACTIVE and workspace status is ACTIVE.
    creating,
    /// Definition has been created/updated. Update/Deletion is disallowed until
    /// definition is ACTIVE and workspace status is ACTIVE.
    active,
    /// Definition is being updated. Update/Deletion is disallowed until definition
    /// is ACTIVE and workspace status is ACTIVE.
    updating,
    /// Definition is being deleting. Update/Deletion is disallowed until definition
    /// is ACTIVE and workspace status is ACTIVE.
    deleting,
    /// Definition creation failed.
    creation_failed,
    /// Definition update failed.
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
