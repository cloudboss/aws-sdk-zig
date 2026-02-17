/// Container element that identifies who initiated the multipart upload.
pub const Initiator = struct {
    /// This functionality is not supported for directory buckets.
    display_name: ?[]const u8,

    /// If the principal is an Amazon Web Services account, it provides the
    /// Canonical User ID. If the principal is an
    /// IAM User, it provides a user ARN value.
    ///
    /// **Directory buckets** - If the principal is an Amazon Web Services account,
    /// it provides the Amazon Web Services account ID. If the principal is an IAM
    /// User, it provides a user ARN
    /// value.
    id: ?[]const u8,
};
