const Type = @import("type.zig").Type;

/// Mapping for named parameters.
pub const ParameterMapping = struct {
    /// Parameter name.
    name: []const u8,

    @"type": Type,

    pub const json_field_names = .{
        .name = "Name",
        .@"type" = "Type",
    };
};
