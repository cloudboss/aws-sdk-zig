const DataLakeSourceStatus = @import("data_lake_source_status.zig").DataLakeSourceStatus;

/// Amazon Security Lake collects logs and events from supported Amazon Web
/// Services services and
/// custom sources. For the list of supported Amazon Web Services services, see
/// the [Amazon Security Lake User
/// Guide](https://docs.aws.amazon.com/security-lake/latest/userguide/internal-sources.html).
pub const DataLakeSource = struct {
    /// The ID of the Security Lake account for which logs are collected.
    account: ?[]const u8,

    /// The Open Cybersecurity Schema Framework (OCSF) event classes describes the
    /// type of
    /// data that the custom source will send to Security Lake. For the list of
    /// supported event classes, see [Supported OCSF Event
    /// classes](https://docs.aws.amazon.com/security-lake/latest/userguide/adding-custom-sources.html#ocsf-eventclass.html) in the Amazon Security Lake User Guide.
    event_classes: ?[]const []const u8,

    /// The supported Amazon Web Services services from which logs and events are
    /// collected.
    /// Amazon Security Lake supports log and event collection for natively
    /// supported Amazon Web Services services.
    source_name: ?[]const u8,

    /// The log status for the Security Lake account.
    source_statuses: ?[]const DataLakeSourceStatus,

    pub const json_field_names = .{
        .account = "account",
        .event_classes = "eventClasses",
        .source_name = "sourceName",
        .source_statuses = "sourceStatuses",
    };
};
