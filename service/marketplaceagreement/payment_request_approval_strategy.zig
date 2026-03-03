const std = @import("std");

pub const PaymentRequestApprovalStrategy = enum {
    auto_approve_on_expiration,
    wait_for_approval,

    pub const json_field_names = .{
        .auto_approve_on_expiration = "AUTO_APPROVE_ON_EXPIRATION",
        .wait_for_approval = "WAIT_FOR_APPROVAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto_approve_on_expiration => "AUTO_APPROVE_ON_EXPIRATION",
            .wait_for_approval => "WAIT_FOR_APPROVAL",
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
