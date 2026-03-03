const std = @import("std");

pub const RequesterGatewayStatus = enum {
    pending_creation,
    active,
    pending_deletion,
    deleted,
    @"error",
    pending_update,
    isolated,
    pending_isolation,
    pending_restoration,

    pub const json_field_names = .{
        .pending_creation = "PENDING_CREATION",
        .active = "ACTIVE",
        .pending_deletion = "PENDING_DELETION",
        .deleted = "DELETED",
        .@"error" = "ERROR",
        .pending_update = "PENDING_UPDATE",
        .isolated = "ISOLATED",
        .pending_isolation = "PENDING_ISOLATION",
        .pending_restoration = "PENDING_RESTORATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_creation => "PENDING_CREATION",
            .active => "ACTIVE",
            .pending_deletion => "PENDING_DELETION",
            .deleted => "DELETED",
            .@"error" => "ERROR",
            .pending_update => "PENDING_UPDATE",
            .isolated => "ISOLATED",
            .pending_isolation => "PENDING_ISOLATION",
            .pending_restoration => "PENDING_RESTORATION",
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
