const std = @import("std");

pub const DeliveryStatus = enum {
    success,
    failed,
    failed_signing_file,
    pending,
    resource_not_found,
    access_denied,
    access_denied_signing_file,
    cancelled,
    unknown,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .failed = "FAILED",
        .failed_signing_file = "FAILED_SIGNING_FILE",
        .pending = "PENDING",
        .resource_not_found = "RESOURCE_NOT_FOUND",
        .access_denied = "ACCESS_DENIED",
        .access_denied_signing_file = "ACCESS_DENIED_SIGNING_FILE",
        .cancelled = "CANCELLED",
        .unknown = "UNKNOWN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .success => "SUCCESS",
            .failed => "FAILED",
            .failed_signing_file => "FAILED_SIGNING_FILE",
            .pending => "PENDING",
            .resource_not_found => "RESOURCE_NOT_FOUND",
            .access_denied => "ACCESS_DENIED",
            .access_denied_signing_file => "ACCESS_DENIED_SIGNING_FILE",
            .cancelled => "CANCELLED",
            .unknown => "UNKNOWN",
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
