const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// Amazon Resource Name (ARN) of the resource. The following examples provide
    /// an example
    /// ARN for each supported resource in License Manager:
    ///
    /// * Licenses -
    /// `arn:aws:license-manager::111122223333:license:l-EXAMPLE2da7646d6861033667f20e895`
    ///
    /// * Grants -
    /// `arn:aws:license-manager::111122223333:grant:g-EXAMPLE7b19f4a0ab73679b0beb52707`
    ///
    /// * License configurations -
    /// `arn:aws:license-manager:us-east-1:111122223333:license-configuration:lic-EXAMPLE6a788d4c8acd4264ff0ecf2ed2d`
    ///
    /// * Report generators -
    /// `arn:aws:license-manager:us-east-1:111122223333:report-generator:r-EXAMPLE825b4a4f8fe5a3e0c88824e5fc6`
    resource_arn: []const u8,

    /// One or more tags.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
