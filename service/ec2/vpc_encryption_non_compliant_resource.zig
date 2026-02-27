/// Describes a resource that is not compliant with VPC encryption requirements.
///
/// For more information, see [Enforce VPC encryption in
/// transit](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-encryption-controls.html) in the *Amazon VPC User Guide*.
pub const VpcEncryptionNonCompliantResource = struct {
    /// A description of the non-compliant resource.
    description: ?[]const u8,

    /// The ID of the non-compliant resource.
    id: ?[]const u8,

    /// Indicates whether the resource can be excluded from encryption enforcement.
    is_excludable: ?bool,

    /// The type of the non-compliant resource.
    type: ?[]const u8,
};
