const std = @import("std");

/// The lifecycle state of a channel.
pub const ChannelStatus = enum {
    creating,
    active,
    updating,
    deleting,
    failed,
    suspending,
    suspended,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .failed = "FAILED",
        .suspending = "SUSPENDING",
        .suspended = "SUSPENDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .active => "ACTIVE",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .failed => "FAILED",
            .suspending => "SUSPENDING",
            .suspended => "SUSPENDED",
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
