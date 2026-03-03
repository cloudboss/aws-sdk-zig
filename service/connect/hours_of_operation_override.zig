const HoursOfOperationOverrideConfig = @import("hours_of_operation_override_config.zig").HoursOfOperationOverrideConfig;
const OverrideType = @import("override_type.zig").OverrideType;
const RecurrenceConfig = @import("recurrence_config.zig").RecurrenceConfig;

/// Information about the hours of operations override.
pub const HoursOfOperationOverride = struct {
    /// Configuration information for the hours of operation override: day, start
    /// time, and end time.
    config: ?[]const HoursOfOperationOverrideConfig = null,

    /// The description of the hours of operation override.
    description: ?[]const u8 = null,

    /// The date from which the hours of operation override would be effective.
    effective_from: ?[]const u8 = null,

    /// The date until the hours of operation override is effective.
    effective_till: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the hours of operation.
    hours_of_operation_arn: ?[]const u8 = null,

    /// The identifier for the hours of operation.
    hours_of_operation_id: ?[]const u8 = null,

    /// The identifier for the hours of operation override.
    hours_of_operation_override_id: ?[]const u8 = null,

    /// The name of the hours of operation override.
    name: ?[]const u8 = null,

    /// Whether the override will be defined as a *standard* or as a *recurring
    /// event*.
    override_type: ?OverrideType = null,

    /// Configuration for a recurring event.
    recurrence_config: ?RecurrenceConfig = null,

    pub const json_field_names = .{
        .config = "Config",
        .description = "Description",
        .effective_from = "EffectiveFrom",
        .effective_till = "EffectiveTill",
        .hours_of_operation_arn = "HoursOfOperationArn",
        .hours_of_operation_id = "HoursOfOperationId",
        .hours_of_operation_override_id = "HoursOfOperationOverrideId",
        .name = "Name",
        .override_type = "OverrideType",
        .recurrence_config = "RecurrenceConfig",
    };
};
