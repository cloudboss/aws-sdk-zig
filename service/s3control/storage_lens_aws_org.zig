/// The Amazon Web Services organization for your S3 Storage Lens.
pub const StorageLensAwsOrg = struct {
    /// A container for the Amazon Resource Name (ARN) of the Amazon Web Services
    /// organization. This property
    /// is read-only and follows the following format: `
    /// arn:aws:organizations:*us-east-1*:*example-account-id*:organization/*o-ex2l495dck*
    /// `
    arn: []const u8,
};
