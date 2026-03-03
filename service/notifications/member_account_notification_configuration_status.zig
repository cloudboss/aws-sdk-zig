const std = @import("std");

pub const MemberAccountNotificationConfigurationStatus = enum {
    /// The member account Notification Configuration status is ACTIVE.
    active,
    /// The member account Notification Configuration status is PENDING.
    pending,
    /// The member account Notification Configuration status is INACTIVE.
    inactive,
    /// The member account Notification Configuration status is CREATING.
    creating,
    /// The member account Notification Configuration status is DELETING.
    deleting,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .pending = "PENDING",
        .inactive = "INACTIVE",
        .creating = "CREATING",
        .deleting = "DELETING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .pending => "PENDING",
            .inactive => "INACTIVE",
            .creating => "CREATING",
            .deleting => "DELETING",
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
