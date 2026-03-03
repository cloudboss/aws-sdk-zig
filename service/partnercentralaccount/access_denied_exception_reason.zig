const std = @import("std");

pub const AccessDeniedExceptionReason = enum {
    access_denied,
    incompatible_benefit_aws_partner_state,

    pub const json_field_names = .{
        .access_denied = "ACCESS_DENIED",
        .incompatible_benefit_aws_partner_state = "INCOMPATIBLE_BENEFIT_AWS_PARTNER_STATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .access_denied => "ACCESS_DENIED",
            .incompatible_benefit_aws_partner_state => "INCOMPATIBLE_BENEFIT_AWS_PARTNER_STATE",
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
