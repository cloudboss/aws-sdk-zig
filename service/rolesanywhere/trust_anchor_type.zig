const std = @import("std");

pub const TrustAnchorType = enum {
    aws_acm_pca,
    certificate_bundle,
    self_signed_repository,

    pub const json_field_names = .{
        .aws_acm_pca = "AWS_ACM_PCA",
        .certificate_bundle = "CERTIFICATE_BUNDLE",
        .self_signed_repository = "SELF_SIGNED_REPOSITORY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_acm_pca => "AWS_ACM_PCA",
            .certificate_bundle => "CERTIFICATE_BUNDLE",
            .self_signed_repository => "SELF_SIGNED_REPOSITORY",
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
