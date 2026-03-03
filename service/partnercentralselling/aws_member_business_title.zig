const std = @import("std");

pub const AwsMemberBusinessTitle = enum {
    aws_sales_rep,
    aws_account_owner,
    wwpspdm,
    pdm,
    psm,
    isvsm,

    pub const json_field_names = .{
        .aws_sales_rep = "AWSSalesRep",
        .aws_account_owner = "AWSAccountOwner",
        .wwpspdm = "WWPSPDM",
        .pdm = "PDM",
        .psm = "PSM",
        .isvsm = "ISVSM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_sales_rep => "AWSSalesRep",
            .aws_account_owner => "AWSAccountOwner",
            .wwpspdm => "WWPSPDM",
            .pdm => "PDM",
            .psm => "PSM",
            .isvsm => "ISVSM",
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
