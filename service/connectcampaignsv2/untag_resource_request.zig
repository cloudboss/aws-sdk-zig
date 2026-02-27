/// The request for UntagResource API.
pub const UntagResourceRequest = struct {
    arn: []const u8,

    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .tag_keys = "tagKeys",
    };
};
