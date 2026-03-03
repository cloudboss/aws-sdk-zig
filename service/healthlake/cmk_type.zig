const std = @import("std");

pub const CmkType = enum {
    cm_cmk,
    ao_cmk,

    pub const json_field_names = .{
        .cm_cmk = "CUSTOMER_MANAGED_KMS_KEY",
        .ao_cmk = "AWS_OWNED_KMS_KEY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cm_cmk => "CUSTOMER_MANAGED_KMS_KEY",
            .ao_cmk => "AWS_OWNED_KMS_KEY",
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
