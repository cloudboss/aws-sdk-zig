const std = @import("std");

pub const WorkspacePolicyStatusCode = enum {
    /// Resource-based Policy is being created. Update/Deletion is disallowed until
    /// Resource-based Policy is ACTIVE and Workspace is ACTIVE.
    creating,
    /// Resource-based Policy has been created/updated. Update/Deletion is
    /// disallowed until Resource-based Policy is ACTIVE and Workspace is ACTIVE.
    active,
    /// Resource-based Policy is being updated. Update/Deletion is disallowed until
    /// Resource-based Policy is ACTIVE and Workspace is ACTIVE.
    updating,
    /// Resource-based Policy is being deleting. Update/Deletion is disallowed until
    /// Resource-based Policy is ACTIVE and Workspace is ACTIVE.
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .active => "ACTIVE",
            .updating => "UPDATING",
            .deleting => "DELETING",
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
