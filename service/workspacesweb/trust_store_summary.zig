/// The summary of the trust store.
pub const TrustStoreSummary = struct {
    /// The ARN of the trust store.
    trust_store_arn: ?[]const u8,

    pub const json_field_names = .{
        .trust_store_arn = "trustStoreArn",
    };
};
