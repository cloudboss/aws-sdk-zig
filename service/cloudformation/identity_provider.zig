const std = @import("std");

pub const IdentityProvider = enum {
    aws_marketplace,
    git_hub,
    bitbucket,

    pub const json_field_names = .{
        .aws_marketplace = "AWS_Marketplace",
        .git_hub = "GitHub",
        .bitbucket = "Bitbucket",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_marketplace => "AWS_Marketplace",
            .git_hub => "GitHub",
            .bitbucket => "Bitbucket",
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
