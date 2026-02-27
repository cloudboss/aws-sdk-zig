pub const SSEKMS = struct {
    /// A container for the ARN of the SSE-KMS encryption. This property is
    /// read-only and
    /// follows the following format: `
    /// arn:aws:kms:*us-east-1*:*example-account-id*:key/*example-9a73-4afc-8d29-8f5900cef44e*
    /// `
    key_id: []const u8,
};
