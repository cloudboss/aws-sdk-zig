const std = @import("std");

/// The lifecycle status of the file system.
pub const FileSystemLifecycle = enum {
    available,
    creating,
    failed,
    deleting,
    misconfigured,
    updating,
    misconfigured_unavailable,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .creating = "CREATING",
        .failed = "FAILED",
        .deleting = "DELETING",
        .misconfigured = "MISCONFIGURED",
        .updating = "UPDATING",
        .misconfigured_unavailable = "MISCONFIGURED_UNAVAILABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "AVAILABLE",
            .creating => "CREATING",
            .failed => "FAILED",
            .deleting => "DELETING",
            .misconfigured => "MISCONFIGURED",
            .updating => "UPDATING",
            .misconfigured_unavailable => "MISCONFIGURED_UNAVAILABLE",
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
