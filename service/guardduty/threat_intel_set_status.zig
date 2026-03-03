const std = @import("std");

pub const ThreatIntelSetStatus = enum {
    inactive,
    activating,
    active,
    deactivating,
    @"error",
    delete_pending,
    deleted,

    pub const json_field_names = .{
        .inactive = "INACTIVE",
        .activating = "ACTIVATING",
        .active = "ACTIVE",
        .deactivating = "DEACTIVATING",
        .@"error" = "ERROR",
        .delete_pending = "DELETE_PENDING",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .inactive => "INACTIVE",
            .activating => "ACTIVATING",
            .active => "ACTIVE",
            .deactivating => "DEACTIVATING",
            .@"error" => "ERROR",
            .delete_pending => "DELETE_PENDING",
            .deleted => "DELETED",
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
