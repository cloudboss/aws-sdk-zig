pub const QDataKeyType = enum {
    aws_owned,
    cmk,

    pub const json_field_names = .{
        .aws_owned = "AWS_OWNED",
        .cmk = "CMK",
    };
};
