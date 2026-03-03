const std = @import("std");

pub const NotificationHubStatus = enum {
    /// Incoming Notification Events are being replicated to this Notification Hub.
    /// A Notification Hub with this status can be deregistered.
    active,
    /// Notification Hub is initializing. Cannot deregister a Notification Hub in
    /// this status.
    registering,
    /// Notification Hub is being deleted. Cannot register a Notification Hub in the
    /// same region as one in this status.
    deregistering,
    /// Notification Hub is in a failure state. Incoming Notification Events are not
    /// being replicated to this Hub.
    inactive,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .registering = "REGISTERING",
        .deregistering = "DEREGISTERING",
        .inactive = "INACTIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .registering => "REGISTERING",
            .deregistering => "DEREGISTERING",
            .inactive => "INACTIVE",
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
