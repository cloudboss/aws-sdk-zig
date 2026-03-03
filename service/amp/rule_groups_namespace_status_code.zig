const std = @import("std");

/// State of a namespace.
pub const RuleGroupsNamespaceStatusCode = enum {
    /// Namespace is being created. Update/Deletion is disallowed until namespace is
    /// ACTIVE and workspace status is ACTIVE.
    creating,
    /// Namespace has been created/updated. Update/Deletion is disallowed until
    /// namespace is ACTIVE and workspace status is ACTIVE.
    active,
    /// Namespace is being updated. Update/Deletion is disallowed until namespace is
    /// ACTIVE and workspace status is ACTIVE.
    updating,
    /// Namespace is being deleting. Update/Deletion is disallowed until namespace
    /// is ACTIVE and workspace status is ACTIVE.
    deleting,
    /// Namespace creation failed.
    creation_failed,
    /// Namespace update failed.
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
