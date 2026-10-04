const std = @import("std");

/// The current status of a qualifications disassociation task. Valid values:
/// `IN_PROGRESS` (task is running), `SUCCEEDED` (task completed successfully).
pub const QualificationsDisassociationTaskStatus = enum {
    in_progress,
    succeeded,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "IN_PROGRESS",
            .succeeded => "SUCCEEDED",
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
