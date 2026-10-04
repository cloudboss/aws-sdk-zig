const std = @import("std");

/// The strategy for resolving tag conflicts between source and destination log
/// groups.
///
/// * `ADD_ONLY` – Only adds new tags from the source without modifying existing
///   destination tags.
/// * `UPDATE_SYNC` – Adds new tags and updates existing tags from the source.
///   Does not remove destination tags that are absent from the source.
/// * `IN_SYNC` – Keeps destination tags fully synchronized with source tags,
///   including removing destination tags that do not exist on the source.
pub const TagConflictResolutionStrategy = enum {
    in_sync,
    add_only,
    update_sync,

    pub const json_field_names = .{
        .in_sync = "IN_SYNC",
        .add_only = "ADD_ONLY",
        .update_sync = "UPDATE_SYNC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_sync => "IN_SYNC",
            .add_only => "ADD_ONLY",
            .update_sync => "UPDATE_SYNC",
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
