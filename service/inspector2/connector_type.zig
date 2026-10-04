const std = @import("std");

pub const ConnectorType = enum {
    customer_managed,
    service_linked,

    pub const json_field_names = .{
        .customer_managed = "CUSTOMER_MANAGED",
        .service_linked = "SERVICE_LINKED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .customer_managed => "CUSTOMER_MANAGED",
            .service_linked => "SERVICE_LINKED",
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
