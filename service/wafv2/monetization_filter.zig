/// A filter for narrowing monetization statistics and settlement record
/// results. Specify a filter name and one or more values to match.
///
/// Filter behavior:
///
/// * Multiple values within one filter: OR (match any)
///
/// * Multiple filters: AND (all must match)
///
/// * No duplicate filter names allowed (rejected with error)
///
/// * Duplicate values within a filter are silently deduplicated
///
/// * If no `CurrencyMode` filter is specified, defaults to `REAL`
pub const MonetizationFilter = struct {
    /// The filter name. Format: Key is a string, Value is a list of strings.
    ///
    /// Enum-restricted (invalid values rejected):
    ///
    /// * `CurrencyMode`: `REAL`, `TEST`
    ///
    /// * `ChainName`: `BASE`, `SOLANA`, `BASE_SEPOLIA`, `SOLANA_DEVNET`
    ///
    /// * `SettlementStatus`: `SETTLED`, `PENDING`, `FAILED`, `SERVICE_ERROR`,
    ///   `SKIPPED_ORIGIN_ERROR`, `DUPLICATE`
    ///
    /// * `HttpSourceName`: `CF`, `ALB`, `APIGW`, `APPRUNNER`, `COGNITO`,
    ///   `VERIFIED_ACCESS`
    ///
    /// ARN-validated:
    ///
    /// * `WebACLArn`: valid WAFv2 web ACL ARN
    ///
    /// Free-text (any string up to 256 chars):
    ///
    /// * `SourceName`: The name of the bot. Populated from Bot Control verified bot
    ///   labels.
    ///
    /// * `SourceCategory`: The category classification of the bot. From Bot Control
    ///   categorization.
    ///
    /// * `Intent`: The declared intent of the bot request.
    ///
    /// * `Organization`: The organization operating the bot.
    ///
    /// * `UriPathPrefix`: The URI path of the request that was monetized.
    ///
    /// * `RequestId`: The WAF request ID associated with the transaction. Matches
    ///   the requestId in WAF logs. Pattern: `^[a-zA-Z0-9:._\-=+/]+$`
    ///
    /// * `TransactionId`: The blockchain transaction identifier. Pattern:
    ///   `^[a-zA-Z0-9:._\-=+/]+$`
    ///
    /// * `TerminatingRuleName`: The name of the WAF rule that triggered the
    ///   Monetize action.
    ///
    /// * `PayerAddress`: The blockchain wallet address of the paying client.
    ///   Pattern: `^[a-zA-Z0-9:._\-=+/]+$`
    ///
    /// * `HttpSourceId`: The identifier of the Amazon Web Services resource
    ///   associated with the web ACL (for example, CloudFront distribution ID).
    name: []const u8,

    /// The values to filter on. Specify as a list of strings. Results match any of
    /// the specified values (OR logic). Duplicate values are silently deduplicated.
    /// Maximum: 20 values per filter.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
