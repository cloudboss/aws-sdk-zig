const std = @import("std");

pub const ContainerFleetLocationStatus = enum {
    pending,
    creating,
    created,
    activating,
    active,
    updating,
    deleting,
    expired,

    pub const json_field_names = .{
        .pending = "PENDING",
        .creating = "CREATING",
        .created = "CREATED",
        .activating = "ACTIVATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .expired = "EXPIRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .creating => "CREATING",
            .created => "CREATED",
            .activating => "ACTIVATING",
            .active => "ACTIVE",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .expired => "EXPIRED",
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
