const std = @import("std");

pub const Type = enum {
    canonical_user,
    amazon_customer_by_email,
    group,

    pub const json_field_names = .{
        .canonical_user = "CanonicalUser",
        .amazon_customer_by_email = "AmazonCustomerByEmail",
        .group = "Group",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .canonical_user => "CanonicalUser",
            .amazon_customer_by_email => "AmazonCustomerByEmail",
            .group => "Group",
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
