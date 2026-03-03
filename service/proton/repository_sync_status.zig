const std = @import("std");

pub const RepositorySyncStatus = enum {
    /// A repository sync attempt has been created and will begin soon.
    initiated,
    /// A repository sync attempt has started and work is being done to reconcile
    /// the branch.
    in_progress,
    /// The repository sync attempt has completed successfully.
    succeeded,
    /// The repository sync attempt has failed.
    failed,
    /// The repository sync attempt didn't execute and was queued.
    queued,

    pub const json_field_names = .{
        .initiated = "INITIATED",
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .queued = "QUEUED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initiated => "INITIATED",
            .in_progress => "IN_PROGRESS",
            .succeeded => "SUCCEEDED",
            .failed => "FAILED",
            .queued => "QUEUED",
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
