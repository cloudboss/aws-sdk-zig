/// Information about a Sidewalk account.
pub const SidewalkAccountInfoWithFingerprint = struct {
    /// The Sidewalk Amazon ID.
    amazon_id: ?[]const u8 = null,

    /// The Amazon Resource Name of the resource.
    arn: ?[]const u8 = null,

    /// The fingerprint of the Sidewalk application server private key.
    fingerprint: ?[]const u8 = null,

    pub const json_field_names = .{
        .amazon_id = "AmazonId",
        .arn = "Arn",
        .fingerprint = "Fingerprint",
    };
};
