const std = @import("std");

pub const EnablementStatus = enum {
    enabled,
    pending_enablement,
    failed_to_enable,
    pending_update,
    failed_to_update,
    pending_deletion,
    deleted,
    failed_to_delete,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .pending_enablement = "PENDING_ENABLEMENT",
        .failed_to_enable = "FAILED_TO_ENABLE",
        .pending_update = "PENDING_UPDATE",
        .failed_to_update = "FAILED_TO_UPDATE",
        .pending_deletion = "PENDING_DELETION",
        .deleted = "DELETED",
        .failed_to_delete = "FAILED_TO_DELETE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "ENABLED",
            .pending_enablement => "PENDING_ENABLEMENT",
            .failed_to_enable => "FAILED_TO_ENABLE",
            .pending_update => "PENDING_UPDATE",
            .failed_to_update => "FAILED_TO_UPDATE",
            .pending_deletion => "PENDING_DELETION",
            .deleted => "DELETED",
            .failed_to_delete => "FAILED_TO_DELETE",
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
