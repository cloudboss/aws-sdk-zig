const InvisibleFieldInfo = @import("invisible_field_info.zig").InvisibleFieldInfo;
const ReadOnlyFieldInfo = @import("read_only_field_info.zig").ReadOnlyFieldInfo;
const RequiredFieldInfo = @import("required_field_info.zig").RequiredFieldInfo;

/// Describes constraints that apply to the template fields.
pub const TaskTemplateConstraints = struct {
    /// Lists the fields that are invisible to agents.
    invisible_fields: ?[]const InvisibleFieldInfo,

    /// Lists the fields that are read-only to agents, and cannot be edited.
    read_only_fields: ?[]const ReadOnlyFieldInfo,

    /// Lists the fields that are required to be filled by agents.
    required_fields: ?[]const RequiredFieldInfo,

    pub const json_field_names = .{
        .invisible_fields = "InvisibleFields",
        .read_only_fields = "ReadOnlyFields",
        .required_fields = "RequiredFields",
    };
};
