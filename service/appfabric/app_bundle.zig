/// Contains information about an app bundle.
pub const AppBundle = struct {
    /// The Amazon Resource Name (ARN) of the app bundle.
    arn: []const u8,

    /// The Amazon Resource Name (ARN) of the Key Management Service (KMS) key
    /// used to encrypt the application data.
    customer_managed_key_arn: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .customer_managed_key_arn = "customerManagedKeyArn",
    };
};
