const std = @import("std");

pub const PortfolioShareType = enum {
    imported,
    aws_servicecatalog,
    aws_organizations,

    pub const json_field_names = .{
        .imported = "IMPORTED",
        .aws_servicecatalog = "AWS_SERVICECATALOG",
        .aws_organizations = "AWS_ORGANIZATIONS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .imported => "IMPORTED",
            .aws_servicecatalog => "AWS_SERVICECATALOG",
            .aws_organizations => "AWS_ORGANIZATIONS",
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
