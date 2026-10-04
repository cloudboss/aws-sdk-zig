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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
