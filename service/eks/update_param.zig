const UpdateParamType = @import("update_param_type.zig").UpdateParamType;

/// An object representing the details of an update request.
pub const UpdateParam = struct {
    /// The keys associated with an update request.
    @"type": ?UpdateParamType = null,

    /// The value of the keys submitted as part of an update request.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .@"type" = "type",
        .value = "value",
    };
};
