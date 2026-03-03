const std = @import("std");

pub const SessionFilterKey = enum {
    invoked_after,
    invoked_before,
    target_id,
    owner,
    status,
    session_id,
    access_type,

    pub const json_field_names = .{
        .invoked_after = "InvokedAfter",
        .invoked_before = "InvokedBefore",
        .target_id = "Target",
        .owner = "Owner",
        .status = "Status",
        .session_id = "SessionId",
        .access_type = "AccessType",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invoked_after => "InvokedAfter",
            .invoked_before => "InvokedBefore",
            .target_id => "Target",
            .owner => "Owner",
            .status => "Status",
            .session_id => "SessionId",
            .access_type => "AccessType",
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
