const std = @import("std");

pub const EnvironmentStatus = enum {
    creating,
    create_failed,
    available,
    updating,
    deleting,
    deleted,
    unavailable,
    update_failed,
    rolling_back,
    creating_snapshot,
    pending,
    maintenance,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .available = "AVAILABLE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .unavailable = "UNAVAILABLE",
        .update_failed = "UPDATE_FAILED",
        .rolling_back = "ROLLING_BACK",
        .creating_snapshot = "CREATING_SNAPSHOT",
        .pending = "PENDING",
        .maintenance = "MAINTENANCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .create_failed => "CREATE_FAILED",
            .available => "AVAILABLE",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .deleted => "DELETED",
            .unavailable => "UNAVAILABLE",
            .update_failed => "UPDATE_FAILED",
            .rolling_back => "ROLLING_BACK",
            .creating_snapshot => "CREATING_SNAPSHOT",
            .pending => "PENDING",
            .maintenance => "MAINTENANCE",
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
