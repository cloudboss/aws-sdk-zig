const std = @import("std");

pub const InstanceRoleCredentialsProvider = enum {
    shared_credential_file,

    pub const json_field_names = .{
        .shared_credential_file = "SHARED_CREDENTIAL_FILE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .shared_credential_file => "SHARED_CREDENTIAL_FILE",
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
