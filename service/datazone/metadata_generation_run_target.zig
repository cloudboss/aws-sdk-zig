const MetadataGenerationTargetType = @import("metadata_generation_target_type.zig").MetadataGenerationTargetType;

/// The asset for which metadata was generated.
pub const MetadataGenerationRunTarget = struct {
    /// The ID of the metadata generation run's target.
    identifier: []const u8,

    /// The revision of the asset for which metadata was generated.
    revision: ?[]const u8,

    /// The type of the asset for which metadata was generated.
    @"type": MetadataGenerationTargetType,

    pub const json_field_names = .{
        .identifier = "identifier",
        .revision = "revision",
        .@"type" = "type",
    };
};
