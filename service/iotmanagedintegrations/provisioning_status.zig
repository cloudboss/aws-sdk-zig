const std = @import("std");

pub const ProvisioningStatus = enum {
    unassociated,
    pre_associated,
    discovered,
    activated,
    deletion_failed,
    delete_in_progress,
    isolated,
    deleted,

    pub const json_field_names = .{
        .unassociated = "UNASSOCIATED",
        .pre_associated = "PRE_ASSOCIATED",
        .discovered = "DISCOVERED",
        .activated = "ACTIVATED",
        .deletion_failed = "DELETION_FAILED",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .isolated = "ISOLATED",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unassociated => "UNASSOCIATED",
            .pre_associated => "PRE_ASSOCIATED",
            .discovered => "DISCOVERED",
            .activated => "ACTIVATED",
            .deletion_failed => "DELETION_FAILED",
            .delete_in_progress => "DELETE_IN_PROGRESS",
            .isolated => "ISOLATED",
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
