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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
