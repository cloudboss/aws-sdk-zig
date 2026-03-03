const std = @import("std");

pub const SsmTargetAccount = enum {
    response_plan_owner_account,
    impacted_account,

    pub const json_field_names = .{
        .response_plan_owner_account = "RESPONSE_PLAN_OWNER_ACCOUNT",
        .impacted_account = "IMPACTED_ACCOUNT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .response_plan_owner_account => "RESPONSE_PLAN_OWNER_ACCOUNT",
            .impacted_account => "IMPACTED_ACCOUNT",
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
