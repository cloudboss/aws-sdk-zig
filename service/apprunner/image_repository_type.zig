const std = @import("std");

pub const ImageRepositoryType = enum {
    ecr,
    ecr_public,

    pub const json_field_names = .{
        .ecr = "ECR",
        .ecr_public = "ECR_PUBLIC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ecr => "ECR",
            .ecr_public => "ECR_PUBLIC",
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
