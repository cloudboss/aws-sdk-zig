const std = @import("std");

/// The type of authentication mechanism used by the data accessor.
pub const DataAccessorAuthenticationType = enum {
    aws_iam_idc_tti,
    aws_iam_idc_auth_code,

    pub const json_field_names = .{
        .aws_iam_idc_tti = "AWS_IAM_IDC_TTI",
        .aws_iam_idc_auth_code = "AWS_IAM_IDC_AUTH_CODE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_iam_idc_tti => "AWS_IAM_IDC_TTI",
            .aws_iam_idc_auth_code => "AWS_IAM_IDC_AUTH_CODE",
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
