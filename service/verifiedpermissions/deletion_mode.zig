const std = @import("std");

/// The deletion mode for a resource. The valid values are:
///
/// * **SoftDelete** – The resource enters the `PendingDeletion` state. This is
///   the default behavior.
/// * **HardDelete** – The resource is immediately deleted, bypassing the
///   `PendingDeletion` state.
pub const DeletionMode = enum {
    soft_delete,
    hard_delete,

    pub const json_field_names = .{
        .soft_delete = "SoftDelete",
        .hard_delete = "HardDelete",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .soft_delete => "SoftDelete",
            .hard_delete => "HardDelete",
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
