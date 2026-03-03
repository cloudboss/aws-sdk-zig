const std = @import("std");

pub const PublishingStatus = enum {
    pending_verification,
    publishing,
    unable_to_publish_fix_destination_property,
    stopped,

    pub const json_field_names = .{
        .pending_verification = "PENDING_VERIFICATION",
        .publishing = "PUBLISHING",
        .unable_to_publish_fix_destination_property = "UNABLE_TO_PUBLISH_FIX_DESTINATION_PROPERTY",
        .stopped = "STOPPED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_verification => "PENDING_VERIFICATION",
            .publishing => "PUBLISHING",
            .unable_to_publish_fix_destination_property => "UNABLE_TO_PUBLISH_FIX_DESTINATION_PROPERTY",
            .stopped => "STOPPED",
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
