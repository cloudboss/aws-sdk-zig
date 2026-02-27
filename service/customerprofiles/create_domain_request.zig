const aws = @import("aws");

const DataStoreRequest = @import("data_store_request.zig").DataStoreRequest;
const MatchingRequest = @import("matching_request.zig").MatchingRequest;
const RuleBasedMatchingRequest = @import("rule_based_matching_request.zig").RuleBasedMatchingRequest;

pub const CreateDomainRequest = struct {
    /// Set to true to enabled data store for this domain.
    data_store: ?DataStoreRequest,

    /// The URL of the SQS dead letter queue, which is used for reporting errors
    /// associated with
    /// ingesting data from third party applications. You must set up a policy on
    /// the
    /// DeadLetterQueue for the SendMessage operation to enable Amazon Connect
    /// Customer Profiles to send
    /// messages to the DeadLetterQueue.
    dead_letter_queue_url: ?[]const u8,

    /// The default encryption key, which is an AWS managed key, is used when no
    /// specific type
    /// of encryption key is specified. It is used to encrypt all data before it is
    /// placed in
    /// permanent or semi-permanent storage.
    default_encryption_key: ?[]const u8,

    /// The default number of days until the data within the domain expires.
    default_expiration_days: i32,

    /// The unique name of the domain.
    domain_name: []const u8,

    /// The process of matching duplicate profiles. If `Matching` = `true`, Amazon
    /// Connect Customer Profiles starts a weekly
    /// batch process called Identity Resolution Job. If you do not specify a date
    /// and time for Identity Resolution Job to run, by default it runs every
    /// Saturday at 12AM UTC to detect duplicate profiles in your domains.
    ///
    /// After the Identity Resolution Job completes, use the
    /// [GetMatches](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_GetMatches.html)
    /// API to return and review the results. Or, if you have configured
    /// `ExportingConfig` in the `MatchingRequest`, you can download the results
    /// from
    /// S3.
    matching: ?MatchingRequest,

    /// The process of matching duplicate profiles using the Rule-Based matching. If
    /// `RuleBasedMatching` = true, Amazon Connect Customer Profiles will start
    /// to match and merge your profiles according to your configuration in the
    /// `RuleBasedMatchingRequest`. You can use the `ListRuleBasedMatches`
    /// and `GetSimilarProfiles` API to return and review the results. Also, if you
    /// have
    /// configured `ExportingConfig` in the `RuleBasedMatchingRequest`, you
    /// can download the results from S3.
    rule_based_matching: ?RuleBasedMatchingRequest,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .data_store = "DataStore",
        .dead_letter_queue_url = "DeadLetterQueueUrl",
        .default_encryption_key = "DefaultEncryptionKey",
        .default_expiration_days = "DefaultExpirationDays",
        .domain_name = "DomainName",
        .matching = "Matching",
        .rule_based_matching = "RuleBasedMatching",
        .tags = "Tags",
    };
};
