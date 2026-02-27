const UniqueTagResourceIdentifier = @import("unique_tag_resource_identifier.zig").UniqueTagResourceIdentifier;

/// The ID
/// for the provisioned product resources
/// that are part
/// of a resource group.
pub const EngineWorkflowResourceIdentifier = struct {
    /// The unique key-value pair
    /// for a tag
    /// that identifies provisioned product resources.
    unique_tag: ?UniqueTagResourceIdentifier,

    pub const json_field_names = .{
        .unique_tag = "UniqueTag",
    };
};
