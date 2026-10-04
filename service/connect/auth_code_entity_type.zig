const std = @import("std");

/// The type of entity associated with an authorization code in Connect
/// Customer.
pub const AuthCodeEntityType = enum {
    customer_profile,

    pub const json_field_names = .{
        .customer_profile = "CUSTOMER_PROFILE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .customer_profile => "CUSTOMER_PROFILE",
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
