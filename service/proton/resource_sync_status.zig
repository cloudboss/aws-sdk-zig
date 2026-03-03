const std = @import("std");

pub const ResourceSyncStatus = enum {
    /// A sync attempt has been created and will begin soon.
    initiated,
    /// Syncing has started and work is being done to reconcile state.
    in_progress,
    /// Syncing has completed successfully.
    succeeded,
    /// Syncing has failed.
    failed,

    pub const json_field_names = .{
        .initiated = "INITIATED",
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initiated => "INITIATED",
            .in_progress => "IN_PROGRESS",
            .succeeded => "SUCCEEDED",
            .failed => "FAILED",
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
