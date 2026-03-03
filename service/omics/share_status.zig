const std = @import("std");

pub const ShareStatus = enum {
    /// The share has been created but is not yet active
    pending,
    /// The share is activated
    activating,
    /// The share is active and can be used
    active,
    /// The share is being deleted
    deleting,
    /// The share has been deleted
    deleted,
    /// The share has failed to activate or delete
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .activating = "ACTIVATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .activating => "ACTIVATING",
            .active => "ACTIVE",
            .deleting => "DELETING",
            .deleted => "DELETED",
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
