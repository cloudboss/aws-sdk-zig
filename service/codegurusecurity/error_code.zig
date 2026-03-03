const std = @import("std");

pub const ErrorCode = enum {
    duplicate_identifier,
    item_does_not_exist,
    internal_error,
    invalid_finding_id,
    invalid_scan_name,

    pub const json_field_names = .{
        .duplicate_identifier = "DUPLICATE_IDENTIFIER",
        .item_does_not_exist = "ITEM_DOES_NOT_EXIST",
        .internal_error = "INTERNAL_ERROR",
        .invalid_finding_id = "INVALID_FINDING_ID",
        .invalid_scan_name = "INVALID_SCAN_NAME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .duplicate_identifier => "DUPLICATE_IDENTIFIER",
            .item_does_not_exist => "ITEM_DOES_NOT_EXIST",
            .internal_error => "INTERNAL_ERROR",
            .invalid_finding_id => "INVALID_FINDING_ID",
            .invalid_scan_name => "INVALID_SCAN_NAME",
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
