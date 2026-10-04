const std = @import("std");

/// The state of a persistent volume.
pub const VolumeState = enum {
    pending_creation,
    pending_attachment,
    in_use,
    available,
    pending_deletion,

    pub const json_field_names = .{
        .pending_creation = "PENDING_CREATION",
        .pending_attachment = "PENDING_ATTACHMENT",
        .in_use = "IN_USE",
        .available = "AVAILABLE",
        .pending_deletion = "PENDING_DELETION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_creation => "PENDING_CREATION",
            .pending_attachment => "PENDING_ATTACHMENT",
            .in_use => "IN_USE",
            .available => "AVAILABLE",
            .pending_deletion => "PENDING_DELETION",
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
