const ModificationResourceEnum = @import("modification_resource_enum.zig").ModificationResourceEnum;
const ModificationStateEnum = @import("modification_state_enum.zig").ModificationStateEnum;

/// Describes a WorkSpace modification.
pub const ModificationState = struct {
    /// The resource.
    resource: ?ModificationResourceEnum,

    /// The modification state.
    state: ?ModificationStateEnum,

    pub const json_field_names = .{
        .resource = "Resource",
        .state = "State",
    };
};
