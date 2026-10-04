/// Represents an entitlement associated with an agreement.
pub const Entitlement = struct {
    /// The Amazon Resource Name (ARN) of the AWS License Manager license associated
    /// with the entitlement.
    license_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .license_arn = "licenseArn",
    };
};
