pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource whose tags you want to
    /// retrieve.
    ///
    /// * Format example:
    ///   `arn:aws:geo:region:account-id:resourcetype/ExampleResource`
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
