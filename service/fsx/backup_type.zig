const std = @import("std");

/// The type of the backup.
pub const BackupType = enum {
    automatic,
    user_initiated,
    aws_backup,

    pub const json_field_names = .{
        .automatic = "AUTOMATIC",
        .user_initiated = "USER_INITIATED",
        .aws_backup = "AWS_BACKUP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .automatic => "AUTOMATIC",
            .user_initiated => "USER_INITIATED",
            .aws_backup => "AWS_BACKUP",
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
