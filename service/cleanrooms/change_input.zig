const ChangeSpecification = @import("change_specification.zig").ChangeSpecification;
const ChangeSpecificationType = @import("change_specification_type.zig").ChangeSpecificationType;

/// Specifies a change to apply to a collaboration.
pub const ChangeInput = struct {
    /// The specification details for the change. The structure depends on the
    /// specification type.
    specification: ChangeSpecification,

    /// The type of specification for the change. Currently supports `MEMBER` for
    /// member-related changes.
    specification_type: ChangeSpecificationType,

    pub const json_field_names = .{
        .specification = "specification",
        .specification_type = "specificationType",
    };
};
