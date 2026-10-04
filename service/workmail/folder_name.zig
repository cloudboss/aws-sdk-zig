const std = @import("std");

pub const FolderName = enum {
    inbox,
    deleted_items,
    sent_items,
    drafts,
    junk_email,

    pub const json_field_names = .{
        .inbox = "INBOX",
        .deleted_items = "DELETED_ITEMS",
        .sent_items = "SENT_ITEMS",
        .drafts = "DRAFTS",
        .junk_email = "JUNK_EMAIL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .inbox => "INBOX",
            .deleted_items => "DELETED_ITEMS",
            .sent_items => "SENT_ITEMS",
            .drafts => "DRAFTS",
            .junk_email => "JUNK_EMAIL",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
