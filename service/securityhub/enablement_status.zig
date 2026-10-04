const std = @import("std");

pub const EnablementStatus = enum {
    enabled,
    pending_enablement,
    failed_to_enable,
    pending_update,
    failed_to_update,
    pending_deletion,
    failed_to_delete,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .pending_enablement = "PENDING_ENABLEMENT",
        .failed_to_enable = "FAILED_TO_ENABLE",
        .pending_update = "PENDING_UPDATE",
        .failed_to_update = "FAILED_TO_UPDATE",
        .pending_deletion = "PENDING_DELETION",
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
            .failed_to_delete => "FAILED_TO_DELETE",
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
