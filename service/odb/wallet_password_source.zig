const std = @import("std");

/// The source of the password for an Autonomous Database wallet.
pub const WalletPasswordSource = enum {
    customer_managed_aws_secret,
    api_request_parameter,

    pub const json_field_names = .{
        .customer_managed_aws_secret = "CUSTOMER_MANAGED_AWS_SECRET",
        .api_request_parameter = "API_REQUEST_PARAMETER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .customer_managed_aws_secret => "CUSTOMER_MANAGED_AWS_SECRET",
            .api_request_parameter => "API_REQUEST_PARAMETER",
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
