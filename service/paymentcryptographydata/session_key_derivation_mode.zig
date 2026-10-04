const std = @import("std");

pub const SessionKeyDerivationMode = enum {
    emv_common_session_key,
    emv2000,
    amex,
    mastercard_session_key,
    visa,
    union_pay,

    pub const json_field_names = .{
        .emv_common_session_key = "EMV_COMMON_SESSION_KEY",
        .emv2000 = "EMV2000",
        .amex = "AMEX",
        .mastercard_session_key = "MASTERCARD_SESSION_KEY",
        .visa = "VISA",
        .union_pay = "UNION_PAY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .emv_common_session_key => "EMV_COMMON_SESSION_KEY",
            .emv2000 => "EMV2000",
            .amex => "AMEX",
            .mastercard_session_key => "MASTERCARD_SESSION_KEY",
            .visa => "VISA",
            .union_pay => "UNION_PAY",
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
