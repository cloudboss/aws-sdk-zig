const DeviceFilterAttribute = @import("device_filter_attribute.zig").DeviceFilterAttribute;
const RuleOperator = @import("rule_operator.zig").RuleOperator;

/// Represents a device filter used to select a set of devices to be included in
/// a test
/// run. This data structure is passed in as the `deviceSelectionConfiguration`
/// parameter to `ScheduleRun`. For an example of the JSON request syntax, see
/// ScheduleRun.
///
/// It is also passed in as the `filters` parameter to
/// `ListDevices`. For an example of the JSON request syntax, see ListDevices.
pub const DeviceFilter = struct {
    /// The aspect of a device such as platform or model used as the selection
    /// criteria in a
    /// device filter.
    ///
    /// The supported operators for each attribute are provided in the following
    /// list.
    ///
    /// **ARN**
    ///
    /// The Amazon Resource Name (ARN) of the device (for example,
    /// `arn:aws:devicefarm:us-west-2::device:12345Example`).
    ///
    /// Supported operators: `EQUALS`, `IN`, `NOT_IN`
    ///
    /// **PLATFORM**
    ///
    /// The device platform. Valid values are ANDROID or IOS.
    ///
    /// Supported operators: `EQUALS`
    ///
    /// **OS_VERSION**
    ///
    /// The operating system version (for example, 10.3.2).
    ///
    /// Supported operators: `EQUALS`, `GREATER_THAN`,
    /// `GREATER_THAN_OR_EQUALS`, `IN`,
    /// `LESS_THAN`, `LESS_THAN_OR_EQUALS`,
    /// `NOT_IN`
    ///
    /// **MODEL**
    ///
    /// The device model (for example, iPad 5th Gen).
    ///
    /// Supported operators: `CONTAINS`, `EQUALS`,
    /// `IN`, `NOT_IN`
    ///
    /// **AVAILABILITY**
    ///
    /// The current availability of the device. Valid values are AVAILABLE,
    /// HIGHLY_AVAILABLE, BUSY, or TEMPORARY_NOT_AVAILABLE.
    ///
    /// Supported operators: `EQUALS`
    ///
    /// **FORM_FACTOR**
    ///
    /// The device form factor. Valid values are PHONE or TABLET.
    ///
    /// Supported operators: `EQUALS`
    ///
    /// **MANUFACTURER**
    ///
    /// The device manufacturer (for example, Apple).
    ///
    /// Supported operators: `EQUALS`, `IN`,
    /// `NOT_IN`
    ///
    /// **REMOTE_ACCESS_ENABLED**
    ///
    /// Whether the device is enabled for remote access. Valid values are TRUE or
    /// FALSE.
    ///
    /// Supported operators: `EQUALS`
    ///
    /// **REMOTE_DEBUG_ENABLED**
    ///
    /// Whether the device is enabled for remote debugging. Valid values are TRUE or
    /// FALSE.
    ///
    /// Supported operators: `EQUALS`
    ///
    /// Because remote debugging is [no
    /// longer
    /// supported](https://docs.aws.amazon.com/devicefarm/latest/developerguide/history.html), this filter is ignored.
    ///
    /// **INSTANCE_ARN**
    ///
    /// The Amazon Resource Name (ARN) of the device instance.
    ///
    /// Supported operators: `EQUALS`, `IN`,
    /// `NOT_IN`
    ///
    /// **INSTANCE_LABELS**
    ///
    /// The label of the device instance.
    ///
    /// Supported operators: `CONTAINS`
    ///
    /// **FLEET_TYPE**
    ///
    /// The fleet type. Valid values are PUBLIC or PRIVATE.
    ///
    /// Supported operators: `EQUALS`
    attribute: DeviceFilterAttribute,

    /// Specifies how Device Farm compares the filter's attribute to the value. See
    /// the attribute
    /// descriptions.
    operator: RuleOperator,

    /// An array of one or more filter values used in a device filter.
    ///
    /// **Operator Values**
    ///
    /// * The IN and NOT_IN operators can take a values array that has more than one
    /// element.
    ///
    /// * The other operators require an array with a single element.
    ///
    /// **Attribute Values**
    ///
    /// * The PLATFORM attribute can be set to ANDROID or IOS.
    ///
    /// * The AVAILABILITY attribute can be set to AVAILABLE, HIGHLY_AVAILABLE,
    ///   BUSY, or
    /// TEMPORARY_NOT_AVAILABLE.
    ///
    /// * The FORM_FACTOR attribute can be set to PHONE or TABLET.
    ///
    /// * The FLEET_TYPE attribute can be set to PUBLIC or PRIVATE.
    values: []const []const u8,

    pub const json_field_names = .{
        .attribute = "attribute",
        .operator = "operator",
        .values = "values",
    };
};
