const std = @import("std");

pub const Oauth2FlowType = enum {
    user_federation,
    m2_m,
    on_behalf_of_token_exchange,

    pub const json_field_names = .{
        .user_federation = "USER_FEDERATION",
        .m2_m = "M2M",
        .on_behalf_of_token_exchange = "ON_BEHALF_OF_TOKEN_EXCHANGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .user_federation => "USER_FEDERATION",
            .m2_m => "M2M",
            .on_behalf_of_token_exchange => "ON_BEHALF_OF_TOKEN_EXCHANGE",
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
