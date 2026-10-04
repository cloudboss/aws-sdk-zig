const std = @import("std");

pub const GuidanceFormat = enum {
    all,
    aws_cli,
    cli,
    python,
    terraform,
    cdk,
    cloudformation,
    iac,
    template,

    pub const json_field_names = .{
        .all = "All",
        .aws_cli = "AwsCli",
        .cli = "Cli",
        .python = "Python",
        .terraform = "Terraform",
        .cdk = "Cdk",
        .cloudformation = "CloudFormation",
        .iac = "IaC",
        .template = "Template",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all => "All",
            .aws_cli => "AwsCli",
            .cli => "Cli",
            .python => "Python",
            .terraform => "Terraform",
            .cdk => "Cdk",
            .cloudformation => "CloudFormation",
            .iac => "IaC",
            .template => "Template",
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
