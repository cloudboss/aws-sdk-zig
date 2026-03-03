const std = @import("std");

pub const IpamResourceDiscoveryAssociationState = enum {
    associate_in_progress,
    associate_complete,
    associate_failed,
    disassociate_in_progress,
    disassociate_complete,
    disassociate_failed,
    isolate_in_progress,
    isolate_complete,
    restore_in_progress,

    pub const json_field_names = .{
        .associate_in_progress = "associate-in-progress",
        .associate_complete = "associate-complete",
        .associate_failed = "associate-failed",
        .disassociate_in_progress = "disassociate-in-progress",
        .disassociate_complete = "disassociate-complete",
        .disassociate_failed = "disassociate-failed",
        .isolate_in_progress = "isolate-in-progress",
        .isolate_complete = "isolate-complete",
        .restore_in_progress = "restore-in-progress",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .associate_in_progress => "associate-in-progress",
            .associate_complete => "associate-complete",
            .associate_failed => "associate-failed",
            .disassociate_in_progress => "disassociate-in-progress",
            .disassociate_complete => "disassociate-complete",
            .disassociate_failed => "disassociate-failed",
            .isolate_in_progress => "isolate-in-progress",
            .isolate_complete => "isolate-complete",
            .restore_in_progress => "restore-in-progress",
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
