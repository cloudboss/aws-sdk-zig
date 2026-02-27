const FieldInfo = @import("field_info.zig").FieldInfo;

/// Details about the query.
pub const QueryInfo = struct {
    /// Returns a `FieldInfo` object.
    select_fields: ?[]const FieldInfo,

    pub const json_field_names = .{
        .select_fields = "SelectFields",
    };
};
