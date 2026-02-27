const ChangeSpecification = @import("change_specification.zig").ChangeSpecification;
const ChangeSpecificationType = @import("change_specification_type.zig").ChangeSpecificationType;
const ChangeType = @import("change_type.zig").ChangeType;

/// Represents a single change within a collaboration change request, containing
/// the change identifier and specification.
pub const Change = struct {
    /// The specification details for this change.
    specification: ChangeSpecification,

    /// The type of specification for this change.
    specification_type: ChangeSpecificationType,

    /// The list of change types that were applied.
    types: []const ChangeType,

    pub const json_field_names = .{
        .specification = "specification",
        .specification_type = "specificationType",
        .types = "types",
    };
};
