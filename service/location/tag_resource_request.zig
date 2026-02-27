const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource whose tags you want to
    /// update.
    ///
    /// * Format example:
    ///   `arn:aws:geo:region:account-id:resourcetype/ExampleResource`
    resource_arn: []const u8,

    /// Applies one or more tags to specific resource. A tag is a key-value pair
    /// that helps you manage, identify, search, and filter your resources.
    ///
    /// Format: `"key" : "value"`
    ///
    /// Restrictions:
    ///
    /// * Maximum 50 tags per resource.
    /// * Each tag key must be unique and must have exactly one associated value.
    /// * Maximum key length: 128 Unicode characters in UTF-8.
    /// * Maximum value length: 256 Unicode characters in UTF-8.
    /// * Can use alphanumeric characters (A–Z, a–z, 0–9), and the following
    ///   characters: + - = . _ : / @
    /// * Cannot use "aws:" as a prefix for a key.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
