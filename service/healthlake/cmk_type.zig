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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
