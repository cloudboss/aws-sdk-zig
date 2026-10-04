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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
