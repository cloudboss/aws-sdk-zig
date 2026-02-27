pub const UntagResourceRequest = struct {
    /// The ARN of the `ScanName` object. You can retrieve this ARN by calling
    /// `CreateScan`, `ListScans`, or `GetScan`.
    resource_arn: []const u8,

    /// A list of keys for each tag you want to remove from a scan.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
