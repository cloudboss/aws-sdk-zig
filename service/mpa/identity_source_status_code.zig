const std = @import("std");

pub const IdentitySourceStatusCode = enum {
    access_denied,
    deletion_failed,
    idc_instance_not_found,
    idc_instance_not_valid,

    pub const json_field_names = .{
        .access_denied = "ACCESS_DENIED",
        .deletion_failed = "DELETION_FAILED",
        .idc_instance_not_found = "IDC_INSTANCE_NOT_FOUND",
        .idc_instance_not_valid = "IDC_INSTANCE_NOT_VALID",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .access_denied => "ACCESS_DENIED",
            .deletion_failed => "DELETION_FAILED",
            .idc_instance_not_found => "IDC_INSTANCE_NOT_FOUND",
            .idc_instance_not_valid => "IDC_INSTANCE_NOT_VALID",
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
