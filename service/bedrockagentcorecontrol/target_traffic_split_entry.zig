const aws = @import("aws");

/// An entry in a target traffic split configuration.
pub const TargetTrafficSplitEntry = struct {
    /// The description of this traffic split variant.
    description: ?[]const u8 = null,

    /// Key-value metadata associated with this traffic split variant.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The name of this traffic split variant.
    name: []const u8,

    /// The name of the target to route traffic to.
    target_name: []const u8,

    /// The percentage of traffic to route to this variant.
    weight: i32,

    pub const json_field_names = .{
        .description = "description",
        .metadata = "metadata",
        .name = "name",
        .target_name = "targetName",
        .weight = "weight",
    };
};
