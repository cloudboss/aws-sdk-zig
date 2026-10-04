const std = @import("std");

pub const KeyType = enum {
    customer_managed_key,
    service_managed_key,

    pub const json_field_names = .{
        .customer_managed_key = "CustomerManagedKey",
        .service_managed_key = "ServiceManagedKey",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .customer_managed_key => "CustomerManagedKey",
            .service_managed_key => "ServiceManagedKey",
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
