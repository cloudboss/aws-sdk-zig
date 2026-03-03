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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
