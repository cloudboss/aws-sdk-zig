const std = @import("std");

pub const FunctionRuntime = enum {
    cloudfront_js_1_0,
    cloudfront_js_2_0,

    pub const json_field_names = .{
        .cloudfront_js_1_0 = "cloudfront-js-1.0",
        .cloudfront_js_2_0 = "cloudfront-js-2.0",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cloudfront_js_1_0 => "cloudfront-js-1.0",
            .cloudfront_js_2_0 => "cloudfront-js-2.0",
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
