const std = @import("std");

pub const AccessDeniedReason = enum {
    iam_auth,
    directory_auth,
    data_disabled,

    pub const json_field_names = .{
        .iam_auth = "IAM_AUTH",
        .directory_auth = "DIRECTORY_AUTH",
        .data_disabled = "DATA_DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .iam_auth => "IAM_AUTH",
            .directory_auth => "DIRECTORY_AUTH",
            .data_disabled => "DATA_DISABLED",
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
