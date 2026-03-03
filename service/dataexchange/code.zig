const std = @import("std");

pub const Code = enum {
    access_denied_exception,
    internal_server_exception,
    malware_detected,
    resource_not_found_exception,
    service_quota_exceeded_exception,
    validation_exception,
    malware_scan_encrypted_file,

    pub const json_field_names = .{
        .access_denied_exception = "ACCESS_DENIED_EXCEPTION",
        .internal_server_exception = "INTERNAL_SERVER_EXCEPTION",
        .malware_detected = "MALWARE_DETECTED",
        .resource_not_found_exception = "RESOURCE_NOT_FOUND_EXCEPTION",
        .service_quota_exceeded_exception = "SERVICE_QUOTA_EXCEEDED_EXCEPTION",
        .validation_exception = "VALIDATION_EXCEPTION",
        .malware_scan_encrypted_file = "MALWARE_SCAN_ENCRYPTED_FILE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .access_denied_exception => "ACCESS_DENIED_EXCEPTION",
            .internal_server_exception => "INTERNAL_SERVER_EXCEPTION",
            .malware_detected => "MALWARE_DETECTED",
            .resource_not_found_exception => "RESOURCE_NOT_FOUND_EXCEPTION",
            .service_quota_exceeded_exception => "SERVICE_QUOTA_EXCEEDED_EXCEPTION",
            .validation_exception => "VALIDATION_EXCEPTION",
            .malware_scan_encrypted_file => "MALWARE_SCAN_ENCRYPTED_FILE",
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
