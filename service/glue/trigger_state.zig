const std = @import("std");

pub const TriggerState = enum {
    creating,
    created,
    activating,
    activated,
    deactivating,
    deactivated,
    deleting,
    updating,

    pub const json_field_names = .{
        .creating = "CREATING",
        .created = "CREATED",
        .activating = "ACTIVATING",
        .activated = "ACTIVATED",
        .deactivating = "DEACTIVATING",
        .deactivated = "DEACTIVATED",
        .deleting = "DELETING",
        .updating = "UPDATING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .created => "CREATED",
            .activating => "ACTIVATING",
            .activated => "ACTIVATED",
            .deactivating => "DEACTIVATING",
            .deactivated => "DEACTIVATED",
            .deleting => "DELETING",
            .updating => "UPDATING",
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
