const std = @import("std");

pub const SummaryMode = enum {
    post_contact,
    automated_interaction,
    contact_chain,

    pub const json_field_names = .{
        .post_contact = "PostContact",
        .automated_interaction = "AutomatedInteraction",
        .contact_chain = "ContactChain",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .post_contact => "PostContact",
            .automated_interaction => "AutomatedInteraction",
            .contact_chain => "ContactChain",
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
