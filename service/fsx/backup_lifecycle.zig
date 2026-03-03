const std = @import("std");

/// The lifecycle status of the backup.
///
/// * `AVAILABLE` - The backup is fully available.
///
/// * `PENDING` - For user-initiated backups on Lustre file systems only; Amazon
///   FSx hasn't started creating the backup.
///
/// * `CREATING` - Amazon FSx is creating the new user-initiated backup.
///
/// * `TRANSFERRING` - For user-initiated backups on Lustre file systems only;
///   Amazon FSx is backing up the file
/// system.
///
/// * `COPYING` - Amazon FSx is copying the backup.
///
/// * `DELETED` - Amazon FSx deleted the backup and it's no longer
/// available.
///
/// * `FAILED` - Amazon FSx couldn't finish the backup.
pub const BackupLifecycle = enum {
    available,
    creating,
    transferring,
    deleted,
    failed,
    pending,
    copying,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .creating = "CREATING",
        .transferring = "TRANSFERRING",
        .deleted = "DELETED",
        .failed = "FAILED",
        .pending = "PENDING",
        .copying = "COPYING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "AVAILABLE",
            .creating => "CREATING",
            .transferring => "TRANSFERRING",
            .deleted => "DELETED",
            .failed => "FAILED",
            .pending => "PENDING",
            .copying => "COPYING",
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
