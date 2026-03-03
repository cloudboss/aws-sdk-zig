const std = @import("std");

pub const EncryptionOption = enum {
    ao_cmk,
    cm_cmk,

    pub const json_field_names = .{
        .ao_cmk = "AWS_OWNED_CMK",
        .cm_cmk = "CUSTOMER_MANAGED_CMK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ao_cmk => "AWS_OWNED_CMK",
            .cm_cmk => "CUSTOMER_MANAGED_CMK",
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
