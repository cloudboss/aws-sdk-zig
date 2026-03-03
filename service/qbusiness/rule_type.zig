const std = @import("std");

pub const RuleType = enum {
    content_blocker_rule,
    content_retrieval_rule,

    pub const json_field_names = .{
        .content_blocker_rule = "CONTENT_BLOCKER_RULE",
        .content_retrieval_rule = "CONTENT_RETRIEVAL_RULE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .content_blocker_rule => "CONTENT_BLOCKER_RULE",
            .content_retrieval_rule => "CONTENT_RETRIEVAL_RULE",
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
