const std = @import("std");

pub const RuleGroupRequestPhase = enum {
    pre_dns,
    pre_req,
    post_res,

    pub const json_field_names = .{
        .pre_dns = "PRE_DNS",
        .pre_req = "PRE_REQ",
        .post_res = "POST_RES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pre_dns => "PRE_DNS",
            .pre_req => "PRE_REQ",
            .post_res => "POST_RES",
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
