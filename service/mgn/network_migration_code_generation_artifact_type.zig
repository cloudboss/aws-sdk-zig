const std = @import("std");

pub const NetworkMigrationCodeGenerationArtifactType = enum {
    cdk_typescript,
    cloudformation_template,
    cdktf_typescript,
    terraform_configuration,
    cdk_l2_typescript,

    pub const json_field_names = .{
        .cdk_typescript = "CDK_TYPESCRIPT",
        .cloudformation_template = "CLOUDFORMATION_TEMPLATE",
        .cdktf_typescript = "CDKTF_TYPESCRIPT",
        .terraform_configuration = "TERRAFORM_CONFIGURATION",
        .cdk_l2_typescript = "CDK_L2_TYPESCRIPT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cdk_typescript => "CDK_TYPESCRIPT",
            .cloudformation_template => "CLOUDFORMATION_TEMPLATE",
            .cdktf_typescript => "CDKTF_TYPESCRIPT",
            .terraform_configuration => "TERRAFORM_CONFIGURATION",
            .cdk_l2_typescript => "CDK_L2_TYPESCRIPT",
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
