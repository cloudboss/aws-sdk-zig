const std = @import("std");

pub const RevisionLocationType = enum {
    s3,
    git_hub,
    string,
    app_spec_content,

    pub const json_field_names = .{
        .s3 = "S3",
        .git_hub = "GitHub",
        .string = "String",
        .app_spec_content = "AppSpecContent",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .s3 => "S3",
            .git_hub => "GitHub",
            .string => "String",
            .app_spec_content => "AppSpecContent",
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
