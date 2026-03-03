const aws = @import("aws");

const HoursOfOperationConfig = @import("hours_of_operation_config.zig").HoursOfOperationConfig;
const HoursOfOperationsIdentifier = @import("hours_of_operations_identifier.zig").HoursOfOperationsIdentifier;

/// Information about of the hours of operation.
pub const HoursOfOperation = struct {
    /// Configuration information for the hours of operation.
    config: ?[]const HoursOfOperationConfig = null,

    /// The description for the hours of operation.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the hours of operation.
    hours_of_operation_arn: ?[]const u8 = null,

    /// The identifier for the hours of operation.
    hours_of_operation_id: ?[]const u8 = null,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64 = null,

    /// The name for the hours of operation.
    name: ?[]const u8 = null,

    /// Information about parent hours of operations.
    parent_hours_of_operations: ?[]const HoursOfOperationsIdentifier = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The time zone for the hours of operation.
    time_zone: ?[]const u8 = null,

    pub const json_field_names = .{
        .config = "Config",
        .description = "Description",
        .hours_of_operation_arn = "HoursOfOperationArn",
        .hours_of_operation_id = "HoursOfOperationId",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .parent_hours_of_operations = "ParentHoursOfOperations",
        .tags = "Tags",
        .time_zone = "TimeZone",
    };
};
