const aws = @import("aws");

const AnalyzerConfiguration = @import("analyzer_configuration.zig").AnalyzerConfiguration;
const AnalyzerStatus = @import("analyzer_status.zig").AnalyzerStatus;
const StatusReason = @import("status_reason.zig").StatusReason;
const Type = @import("type.zig").Type;

/// Contains information about the analyzer.
pub const AnalyzerSummary = struct {
    /// The ARN of the analyzer.
    arn: []const u8,

    /// Specifies if the analyzer is an external access, unused access, or internal
    /// access analyzer. The
    /// [GetAnalyzer](https://docs.aws.amazon.com/access-analyzer/latest/APIReference/API_GetAnalyzer.html) action includes this property in its response if a configuration is specified, while the [ListAnalyzers](https://docs.aws.amazon.com/access-analyzer/latest/APIReference/API_ListAnalyzers.html) action omits it.
    configuration: ?AnalyzerConfiguration = null,

    /// A timestamp for the time at which the analyzer was created.
    created_at: i64,

    /// The resource that was most recently analyzed by the analyzer.
    last_resource_analyzed: ?[]const u8 = null,

    /// The time at which the most recently analyzed resource was analyzed.
    last_resource_analyzed_at: ?i64 = null,

    /// The name of the analyzer.
    name: []const u8,

    /// The status of the analyzer. An `Active` analyzer successfully monitors
    /// supported resources and generates new findings. The analyzer is `Disabled`
    /// when a user action, such as removing trusted access for Identity and Access
    /// Management Access Analyzer from Organizations, causes the analyzer to stop
    /// generating new findings. The status is `Creating` when the analyzer creation
    /// is in progress and `Failed` when the analyzer creation has failed.
    status: AnalyzerStatus,

    /// The `statusReason` provides more details about the current status of the
    /// analyzer. For example, if the creation for the analyzer fails, a `Failed`
    /// status is returned. For an analyzer with organization as the type, this
    /// failure can be due to an issue with creating the service-linked roles
    /// required in the member accounts of the Amazon Web Services organization.
    status_reason: ?StatusReason = null,

    /// An array of key-value pairs applied to the analyzer. The key-value pairs
    /// consist of the set of Unicode letters, digits, whitespace, `_`, `.`, `/`,
    /// `=`, `+`, and `-`.
    ///
    /// The tag key is a value that is 1 to 128 characters in length and cannot be
    /// prefixed with `aws:`.
    ///
    /// The tag value is a value that is 0 to 256 characters in length.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type represents the zone of trust or scope for the analyzer.
    @"type": Type,

    pub const json_field_names = .{
        .arn = "arn",
        .configuration = "configuration",
        .created_at = "createdAt",
        .last_resource_analyzed = "lastResourceAnalyzed",
        .last_resource_analyzed_at = "lastResourceAnalyzedAt",
        .name = "name",
        .status = "status",
        .status_reason = "statusReason",
        .tags = "tags",
        .@"type" = "type",
    };
};
