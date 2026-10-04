const std = @import("std");

pub const ServiceQuotaExceededExceptionReason = enum {
    service_quota_exceeded,

    pub const json_field_names = .{
        .service_quota_exceeded = "SERVICE_QUOTA_EXCEEDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .service_quota_exceeded => "SERVICE_QUOTA_EXCEEDED",
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
