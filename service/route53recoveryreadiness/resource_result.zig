const Readiness = @import("readiness.zig").Readiness;

/// The result of a successful Resource request, with status for an individual
/// resource.
pub const ResourceResult = struct {
    /// The component id of the resource.
    component_id: ?[]const u8,

    /// The time (UTC) that the resource was last checked for readiness, in ISO-8601
    /// format.
    last_checked_timestamp: i64,

    /// The readiness of a resource.
    readiness: Readiness,

    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: ?[]const u8,

    pub const json_field_names = .{
        .component_id = "ComponentId",
        .last_checked_timestamp = "LastCheckedTimestamp",
        .readiness = "Readiness",
        .resource_arn = "ResourceArn",
    };
};
