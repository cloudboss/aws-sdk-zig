const std = @import("std");

pub const OutputLocationType = enum {
    customer_bucket,
    service_bucket,

    pub const json_field_names = .{
        .customer_bucket = "CUSTOMER_BUCKET",
        .service_bucket = "SERVICE_BUCKET",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .customer_bucket => "CUSTOMER_BUCKET",
            .service_bucket => "SERVICE_BUCKET",
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
