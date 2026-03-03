const std = @import("std");

/// The subscription type of the subscriber. It can be SMS or EMAIL.
pub const SubscriptionType = enum {
    sns,
    email,

    pub const json_field_names = .{
        .sns = "SNS",
        .email = "EMAIL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sns => "SNS",
            .email => "EMAIL",
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
