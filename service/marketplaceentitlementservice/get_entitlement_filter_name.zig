const std = @import("std");

pub const GetEntitlementFilterName = enum {
    customer_identifier,
    dimension,
    customer_aws_account_id,

    pub const json_field_names = .{
        .customer_identifier = "CUSTOMER_IDENTIFIER",
        .dimension = "DIMENSION",
        .customer_aws_account_id = "CUSTOMER_AWS_ACCOUNT_ID",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .customer_identifier => "CUSTOMER_IDENTIFIER",
            .dimension => "DIMENSION",
            .customer_aws_account_id => "CUSTOMER_AWS_ACCOUNT_ID",
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
