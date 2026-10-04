const std = @import("std");

pub const ViewerProtocolPolicy = enum {
    allow_all,
    https_only,
    redirect_to_https,

    pub const json_field_names = .{
        .allow_all = "allow-all",
        .https_only = "https-only",
        .redirect_to_https = "redirect-to-https",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .allow_all => "allow-all",
            .https_only => "https-only",
            .redirect_to_https => "redirect-to-https",
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
