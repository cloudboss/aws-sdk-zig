const std = @import("std");

pub const AuthenticationMethodOption = enum {
    iam_and_quicksight,
    iam_only,
    active_directory,
    iam_identity_center,

    pub const json_field_names = .{
        .iam_and_quicksight = "IAM_AND_QUICKSIGHT",
        .iam_only = "IAM_ONLY",
        .active_directory = "ACTIVE_DIRECTORY",
        .iam_identity_center = "IAM_IDENTITY_CENTER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .iam_and_quicksight => "IAM_AND_QUICKSIGHT",
            .iam_only => "IAM_ONLY",
            .active_directory => "ACTIVE_DIRECTORY",
            .iam_identity_center => "IAM_IDENTITY_CENTER",
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
