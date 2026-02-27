const aws = @import("aws");

/// Describes a resolved target.
pub const ResolvedTarget = struct {
    /// The resource type of the target.
    resource_type: ?[]const u8,

    /// Information about the target.
    target_information: ?[]const aws.map.StringMapEntry,

    /// The name of the target.
    target_name: ?[]const u8,

    pub const json_field_names = .{
        .resource_type = "resourceType",
        .target_information = "targetInformation",
        .target_name = "targetName",
    };
};
