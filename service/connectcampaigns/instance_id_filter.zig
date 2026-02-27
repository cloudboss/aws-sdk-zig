const InstanceIdFilterOperator = @import("instance_id_filter_operator.zig").InstanceIdFilterOperator;

/// Connect instance identifier filter
pub const InstanceIdFilter = struct {
    operator: InstanceIdFilterOperator,

    value: []const u8,

    pub const json_field_names = .{
        .operator = "operator",
        .value = "value",
    };
};
