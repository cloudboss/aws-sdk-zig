const ArchitectureType = @import("architecture_type.zig").ArchitectureType;
const InstanceRequirementsRequest = @import("instance_requirements_request.zig").InstanceRequirementsRequest;
const VirtualizationType = @import("virtualization_type.zig").VirtualizationType;

/// The architecture type, virtualization type, and other attributes for the
/// instance types.
/// When you specify instance attributes, Amazon EC2 will identify instance
/// types with those
/// attributes.
///
/// If you specify `InstanceRequirementsWithMetadataRequest`, you can't specify
/// `InstanceTypes`.
pub const InstanceRequirementsWithMetadataRequest = struct {
    /// The architecture type.
    architecture_types: ?[]const ArchitectureType,

    /// The attributes for the instance types. When you specify instance attributes,
    /// Amazon EC2 will
    /// identify instance types with those attributes.
    instance_requirements: ?InstanceRequirementsRequest,

    /// The virtualization type.
    virtualization_types: ?[]const VirtualizationType,
};
