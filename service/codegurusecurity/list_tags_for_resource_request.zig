pub const ListTagsForResourceRequest = struct {
    /// The ARN of the `ScanName` object. You can retrieve this ARN by calling
    /// `CreateScan`, `ListScans`, or `GetScan`.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
