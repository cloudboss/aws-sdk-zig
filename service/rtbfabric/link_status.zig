const std = @import("std");

pub const LinkStatus = enum {
    pending_creation,
    pending_request,
    requested,
    accepted,
    active,
    rejected,
    failed,
    pending_deletion,
    deleted,
    pending_update,
    pending_isolation,
    isolated,
    pending_restoration,

    pub const json_field_names = .{
        .pending_creation = "PENDING_CREATION",
        .pending_request = "PENDING_REQUEST",
        .requested = "REQUESTED",
        .accepted = "ACCEPTED",
        .active = "ACTIVE",
        .rejected = "REJECTED",
        .failed = "FAILED",
        .pending_deletion = "PENDING_DELETION",
        .deleted = "DELETED",
        .pending_update = "PENDING_UPDATE",
        .pending_isolation = "PENDING_ISOLATION",
        .isolated = "ISOLATED",
        .pending_restoration = "PENDING_RESTORATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_creation => "PENDING_CREATION",
            .pending_request => "PENDING_REQUEST",
            .requested => "REQUESTED",
            .accepted => "ACCEPTED",
            .active => "ACTIVE",
            .rejected => "REJECTED",
            .failed => "FAILED",
            .pending_deletion => "PENDING_DELETION",
            .deleted => "DELETED",
            .pending_update => "PENDING_UPDATE",
            .pending_isolation => "PENDING_ISOLATION",
            .isolated => "ISOLATED",
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
