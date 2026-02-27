const CachePointType = @import("cache_point_type.zig").CachePointType;

/// Indicates where a cache checkpoint is located. All information before this
/// checkpoint is cached to be accessed on subsequent requests.
pub const CachePointBlock = struct {
    /// Indicates that the CachePointBlock is of the default type
    @"type": CachePointType,

    pub const json_field_names = .{
        .@"type" = "type",
    };
};
