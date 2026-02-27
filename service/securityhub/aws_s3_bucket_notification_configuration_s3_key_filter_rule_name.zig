pub const AwsS3BucketNotificationConfigurationS3KeyFilterRuleName = enum {
    prefix,
    suffix,

    pub const json_field_names = .{
        .prefix = "PREFIX",
        .suffix = "SUFFIX",
    };
};
