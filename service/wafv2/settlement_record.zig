const Currency = @import("currency.zig").Currency;
const SettlementStatus = @import("settlement_status.zig").SettlementStatus;

/// A single settlement transaction record for AI bot monetization. Contains
/// details about the payment including timestamp, amount, status, and the
/// parties involved.
pub const SettlementRecord = struct {
    /// The payment amount in the specified currency.
    amount: []const u8,

    /// The content path that was accessed.
    content_path: ?[]const u8 = null,

    /// The currency of the payment amount.
    currency: ?Currency = null,

    /// The declared intent of the AI bot request.
    intent: ?[]const u8 = null,

    /// The blockchain network on which the settlement occurred.
    network: ?[]const u8 = null,

    /// The organization associated with the AI bot.
    organization: ?[]const u8 = null,

    /// The blockchain wallet address of the paying AI agent.
    payer_address: ?[]const u8 = null,

    /// The WAF request ID associated with this settlement.
    request_id: ?[]const u8 = null,

    /// The timestamp of the original web request.
    request_timestamp: ?i64 = null,

    /// The category of the AI bot source.
    source_category: ?[]const u8 = null,

    /// The name of the AI bot that made the payment.
    source_name: ?[]const u8 = null,

    /// The status of the settlement. Possible values:
    ///
    /// * `SETTLED` - The payment was successfully settled on the blockchain and the
    ///   transfer from the payer's wallet to the publisher's wallet is confirmed.
    ///   The `TransactionId` field contains the on-chain transaction hash. Content
    ///   is served to the client.
    ///
    /// * `PENDING` - The blockchain transaction has been submitted but not yet
    ///   confirmed on-chain. This is a transient state that automatically resolves
    ///   to either `SETTLED` or `FAILED`. No action is required. While pending,
    ///   content is not served and the API returns a 402 response. Clients can
    ///   retry the request.
    ///
    /// * `FAILED` - The payment settlement was attempted but failed. Possible
    ///   causes include insufficient funds, an expired payment authorization, or a
    ///   reverted blockchain transaction. The `failureReason` field contains a
    ///   machine-readable error code. Content is not served.
    ///
    /// * `SERVICE_ERROR` - Settlement could not be completed due to an internal
    ///   service issue or an issue with the payment network. Content is not served.
    ///   The client's payment authorization remains valid and the request can be
    ///   retried.
    ///
    /// * `SKIPPED_ORIGIN_ERROR` - The origin returned a non-2xx response, so
    ///   settlement was intentionally skipped. The client is not charged.
    ///
    /// * `DUPLICATE` - A prior request with the same payment payload has already
    ///   been settled. This status typically appears when a previous attempt timed
    ///   out but the payment was ultimately processed. The client is not charged
    ///   again.
    status: SettlementStatus,

    /// The timestamp when the settlement was recorded.
    timestamp: i64,

    /// The blockchain transaction identifier. You can use this to verify the
    /// transaction on a blockchain explorer.
    transaction_id: ?[]const u8 = null,

    /// Whether the AI bot's identity was verified.
    verified: bool = false,

    /// Your receiving wallet address.
    wallet_address: ?[]const u8 = null,

    /// The ARN of the web ACL that processed the request.
    web_acl_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .amount = "Amount",
        .content_path = "ContentPath",
        .currency = "Currency",
        .intent = "Intent",
        .network = "Network",
        .organization = "Organization",
        .payer_address = "PayerAddress",
        .request_id = "RequestId",
        .request_timestamp = "RequestTimestamp",
        .source_category = "SourceCategory",
        .source_name = "SourceName",
        .status = "Status",
        .timestamp = "Timestamp",
        .transaction_id = "TransactionId",
        .verified = "Verified",
        .wallet_address = "WalletAddress",
        .web_acl_arn = "WebAclArn",
    };
};
