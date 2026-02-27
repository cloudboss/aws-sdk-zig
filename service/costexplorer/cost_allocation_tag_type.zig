pub const CostAllocationTagType = enum {
    aws_generated,
    user_defined,

    pub const json_field_names = .{
        .aws_generated = "AWS_GENERATED",
        .user_defined = "USER_DEFINED",
    };
};
