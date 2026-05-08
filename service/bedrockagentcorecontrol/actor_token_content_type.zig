const std = @import("std");

pub const ActorTokenContentType = enum {
    none,
    m2_m,
    aws_iam_id_token_jwt,

    pub const json_field_names = .{
        .none = "NONE",
        .m2_m = "M2M",
        .aws_iam_id_token_jwt = "AWS_IAM_ID_TOKEN_JWT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .m2_m => "M2M",
            .aws_iam_id_token_jwt => "AWS_IAM_ID_TOKEN_JWT",
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
