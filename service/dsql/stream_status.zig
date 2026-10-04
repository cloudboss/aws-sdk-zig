const std = @import("std");

/// The current status of a stream.
///
/// **CREATING**
///
/// The stream is being created.
///
/// **ACTIVE**
///
/// The stream is active and processing changes.
///
/// **DELETING**
///
/// The stream is being deleted.
///
/// **DELETED**
///
/// The stream has been deleted.
///
/// **FAILED**
///
/// The stream has failed.
///
/// **IMPAIRED**
///
/// The stream is impaired and may not be processing changes correctly.
pub const StreamStatus = enum {
    creating,
    active,
    deleting,
    deleted,
    failed,
    impaired,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .failed = "FAILED",
        .impaired = "IMPAIRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .active => "ACTIVE",
            .deleting => "DELETING",
            .deleted => "DELETED",
            .failed => "FAILED",
            .impaired => "IMPAIRED",
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
