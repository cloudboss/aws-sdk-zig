const std = @import("std");

pub const RuleAction = enum {
    create_listing_change_set,
    create_subscription_request,

    pub const json_field_names = .{
        .create_listing_change_set = "CREATE_LISTING_CHANGE_SET",
        .create_subscription_request = "CREATE_SUBSCRIPTION_REQUEST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_listing_change_set => "CREATE_LISTING_CHANGE_SET",
            .create_subscription_request => "CREATE_SUBSCRIPTION_REQUEST",
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
