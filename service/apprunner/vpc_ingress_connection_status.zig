const std = @import("std");

pub const VpcIngressConnectionStatus = enum {
    available,
    pending_creation,
    pending_update,
    pending_deletion,
    failed_creation,
    failed_update,
    failed_deletion,
    deleted,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .pending_creation = "PENDING_CREATION",
        .pending_update = "PENDING_UPDATE",
        .pending_deletion = "PENDING_DELETION",
        .failed_creation = "FAILED_CREATION",
        .failed_update = "FAILED_UPDATE",
        .failed_deletion = "FAILED_DELETION",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "AVAILABLE",
            .pending_creation => "PENDING_CREATION",
            .pending_update => "PENDING_UPDATE",
            .pending_deletion => "PENDING_DELETION",
            .failed_creation => "FAILED_CREATION",
            .failed_update => "FAILED_UPDATE",
            .failed_deletion => "FAILED_DELETION",
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
