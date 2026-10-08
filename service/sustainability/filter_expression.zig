const aws = @import("aws");

/// Filters environmental impact values by specific dimension values.
pub const FilterExpression = struct {
    /// Filters environmental impact values by specific dimension values.
    dimensions: ?[]const aws.map.MapEntry([]const []const u8) = null,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
    };
};
