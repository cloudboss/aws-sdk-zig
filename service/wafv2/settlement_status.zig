const std = @import("std");

pub const SettlementStatus = enum {
    settled,
    pending,
    failed,
    service_error,
    skipped_origin_error,
    duplicate,

    pub const json_field_names = .{
        .settled = "SETTLED",
        .pending = "PENDING",
        .failed = "FAILED",
        .service_error = "SERVICE_ERROR",
        .skipped_origin_error = "SKIPPED_ORIGIN_ERROR",
        .duplicate = "DUPLICATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .settled => "SETTLED",
            .pending => "PENDING",
            .failed => "FAILED",
            .service_error => "SERVICE_ERROR",
            .skipped_origin_error => "SKIPPED_ORIGIN_ERROR",
            .duplicate => "DUPLICATE",
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
