const std = @import("std");

pub const Ownership = enum {
    self,
    shared,
    amazon,
    thirdparty,
    aws_marketplace,

    pub const json_field_names = .{
        .self = "Self",
        .shared = "Shared",
        .amazon = "Amazon",
        .thirdparty = "ThirdParty",
        .aws_marketplace = "AWSMarketplace",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .self => "Self",
            .shared => "Shared",
            .amazon => "Amazon",
            .thirdparty => "ThirdParty",
            .aws_marketplace => "AWSMarketplace",
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
