const std = @import("std");

pub const IdentityType = enum {
    iam,
    quicksight,
    iam_identity_center,

    pub const json_field_names = .{
        .iam = "IAM",
        .quicksight = "QUICKSIGHT",
        .iam_identity_center = "IAM_IDENTITY_CENTER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .iam => "IAM",
            .quicksight => "QUICKSIGHT",
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
