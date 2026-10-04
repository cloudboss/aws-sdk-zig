const std = @import("std");

pub const AnalyticsMode = enum {
    post_contact,
    real_time,
    contact_lens,
    automated_interaction,

    pub const json_field_names = .{
        .post_contact = "PostContact",
        .real_time = "RealTime",
        .contact_lens = "ContactLens",
        .automated_interaction = "AutomatedInteraction",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .post_contact => "PostContact",
            .real_time => "RealTime",
            .contact_lens => "ContactLens",
            .automated_interaction => "AutomatedInteraction",
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
