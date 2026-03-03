/// Describes a resource that is not compliant with VPC encryption requirements.
///
/// For more information, see [Enforce VPC encryption in
/// transit](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-encryption-controls.html) in the *Amazon VPC User Guide*.
pub const VpcEncryptionNonCompliantResource = struct {
    /// A description of the non-compliant resource.
    description: ?[]const u8 = null,

    /// The ID of the non-compliant resource.
    id: ?[]const u8 = null,

    /// Indicates whether the resource can be excluded from encryption enforcement.
    is_excludable: ?bool = null,

    /// The type of the non-compliant resource.
    @"type": ?[]const u8 = null,
};
