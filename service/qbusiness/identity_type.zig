const std = @import("std");

pub const IdentityType = enum {
    aws_iam_idp_saml,
    aws_iam_idp_oidc,
    aws_iam_idc,
    aws_quicksight_idp,
    anonymous,

    pub const json_field_names = .{
        .aws_iam_idp_saml = "AWS_IAM_IDP_SAML",
        .aws_iam_idp_oidc = "AWS_IAM_IDP_OIDC",
        .aws_iam_idc = "AWS_IAM_IDC",
        .aws_quicksight_idp = "AWS_QUICKSIGHT_IDP",
        .anonymous = "ANONYMOUS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_iam_idp_saml => "AWS_IAM_IDP_SAML",
            .aws_iam_idp_oidc => "AWS_IAM_IDP_OIDC",
            .aws_iam_idc => "AWS_IAM_IDC",
            .aws_quicksight_idp => "AWS_QUICKSIGHT_IDP",
            .anonymous => "ANONYMOUS",
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
