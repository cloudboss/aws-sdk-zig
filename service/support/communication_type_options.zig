const DateInterval = @import("date_interval.zig").DateInterval;
const SupportedHour = @import("supported_hour.zig").SupportedHour;

/// A JSON-formatted object that contains the CommunicationTypeOptions for
/// creating a case for a certain
/// communication channel. It is contained in the response from a
/// DescribeCreateCaseOptions request. **CommunicationTypeOptions** contains the
/// following fields:
///
/// * **datesWithoutSupport** -
/// A JSON-formatted list containing date and time ranges for periods
/// without support in UTC time. Date and time format is RFC 3339 :
/// 'yyyy-MM-dd'T'HH:mm:ss.SSSZZ'.
///
/// * **supportedHours** -
/// A JSON-formatted list containing time ranges when support are available.
/// Time format is RFC 3339 : 'HH:mm:ss.SSS'.
///
/// * **type** -
/// A string value indicating the communication type that the aforementioned
/// rules apply to. At the moment
/// the type value can assume one of 3 values at the moment `chat`, `web` and
/// `call`.
pub const CommunicationTypeOptions = struct {
    /// A JSON-formatted list containing date and time ranges for periods without
    /// support
    dates_without_support: ?[]const DateInterval,

    /// A JSON-formatted list containing time ranges when support is available.
    supported_hours: ?[]const SupportedHour,

    /// A string value indicating the communication type. At the moment the type
    /// value can assume one of 3 values at the moment chat, web and call.
    type: ?[]const u8,

    pub const json_field_names = .{
        .dates_without_support = "datesWithoutSupport",
        .supported_hours = "supportedHours",
        .type = "type",
    };
};
